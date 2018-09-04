//
//  BookController.swift
//  Reading List
//
//  Created by Jason Modisett on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() { loadFromPersistentStore() }
    
    // Creating a new book instance and appending it to the books array
    func createBook(with title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    // Updating a specific book in our books array
    func update(book: Book, title: String, reasonToRead: String, hasBeenRead: Bool) {
        guard let index = books.index(of: book) else { return }
        
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        books[index].hasBeenRead = hasBeenRead
        
        saveToPersistentStore()
    }
    
    // Deleting a book from the books array and updating our persistent storage plist
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    // Saving books in persistent storage
    private func saveToPersistentStore() {
        do {
            let plistEncoder = PropertyListEncoder()
            
            let booksData = try plistEncoder.encode(books)
            
            guard let booksFileURL = booksFileURL else { return }
            
            try booksData.write(to: booksFileURL)
        } catch {
            NSLog("Error encoding books: \(error)")
        }
    }
    
    // Loading books for persistent storage
    private func loadFromPersistentStore() {
        do {
            guard let booksFileURL = booksFileURL,
                      FileManager.default.fileExists(atPath: booksFileURL.path) else { return }
        
            let booksData = try Data(contentsOf: booksFileURL)
            
            let plistDecoder = PropertyListDecoder()
            
            self.books = try plistDecoder.decode([Book].self, from: booksData)
        } catch {
            NSLog("Error decoding books: \(error)")
        }
    }
    
    // File directory for our books.plist file
    private var booksFileURL: URL? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = "books.plist"
        
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead }
    }
    
    var unreadBooks: [Book] {
        return books.filter { !$0.hasBeenRead }
    }
    
    // Array of books
    private(set) var books: [Book] = []
}
