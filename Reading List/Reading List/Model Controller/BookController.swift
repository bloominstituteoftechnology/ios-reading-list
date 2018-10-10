import Foundation

class BookController {
    var books: [Book] = []
    
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.index(of: book) {
            var book = books[index]
            book.hasBeenRead = !book.hasBeenRead
            books.remove(at: index)
            books.insert(book, at: index)
        }
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, title: String, reasonToRead: String) {
        if let index = books.index(of: book) {
            var book = books[index]
            book.title = title
            book.reasonToRead = reasonToRead
            books.remove(at: index)
            books.insert(book, at: index)
        }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            books = sortAlphabetically(for: books)
            let endcoder = PropertyListEncoder()
            let booksData = try endcoder.encode(books)
            if let readingListURL = readingListURL {
                try booksData.write(to: readingListURL)
            }
        } catch {
            NSLog("An error occured while saving book: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            // Decode data at path readingListURL and update books array
            let decoder = PropertyListDecoder()
            guard let readingListURL = readingListURL else { return }
            let data = try Data(contentsOf: readingListURL)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
            
        } catch {
            NSLog("An error occured while loading book: \(error)")
        }
    }
    
    func sortAlphabetically(for books: [Book]) -> [Book] {
        return books.sorted( by: { $0.title < $1.title } )
    }
    
    var readingListURL: URL? {
        let fm = FileManager()
        let fileName = "ReadingList.plist"
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent(fileName)
    }
    
    var readBooks: [Book] {
        return books.filter( { $0.hasBeenRead == true } )
    }
    
    var unreadBooks: [Book] {
        return books.filter( { $0.hasBeenRead == false } )
    }
}
