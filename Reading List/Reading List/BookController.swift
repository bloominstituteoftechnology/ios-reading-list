//
//  BookController.swift
//  Reading List
//
//  Created by Vici Shaweddy on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        let filter =  books.filter { (book) -> Bool in
            return book.hasBeenRead
        }
        return sortedBook(book: filter)
    }
    
    var unreadBooks: [Book] {
        let filter = books.filter { (book) -> Bool in
            return book.hasBeenRead == false
        }
        return sortedBook(book: filter)
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func createBook(named name: String, reasoned reasonToRead: String, readStatus hasBeenRead: Bool ) -> Book {
        
        let book = Book(name: name, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        let offset = books.distance(from: books.startIndex, to: index)
        books.remove(at: offset)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func editBook(book: Book, newName: String, newReason: String) {
        guard let index = books.index(of: book) else { return }
        books[index].name = newName
        books[index].reasonToRead = newReason
        saveToPersistentStore()
    }
    
    func sortedBook(book: [Book]) -> [Book] {
        return book.sorted(by: { (firstBook, secondBook) -> Bool in
            return firstBook.name < secondBook.name
        })
    }
    
    // responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    //responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
