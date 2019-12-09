
import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    // MARK: - Properties
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }


    // Creating a .plist file for our persistent storage.
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    // Creating a Book
    @discardableResult func createBook(_ title: String, _ reason: String, hasBeenRead: Bool = false) -> Book {
        let book = Book(title: title, reasonToRead: reason, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    // Deleting a Book
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
    }
    
    func updateHasBeenRead(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead.toggle()
    }
    
    func editBookInfo(book: Book, title: String, reasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book),
            !title.isEmpty,
            !reasonToRead.isEmpty else { return }
        books[bookIndex].title = title
        books[bookIndex].reasonToRead = reasonToRead
    }
    
    
    // saving to our .plist if we have it.
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }

    // Loading from our .plist
    func loadFromPersistentStore() {
    
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data \(error)")
        }
    }
}

