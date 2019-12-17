//
//  BookController.swift
//  Reading List
//
//  Created by user162867 on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books : [Book] = []
    
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func createStar(with title: String, reasonToRead: String, hasBeenRead: Book) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        saveToPersistentStore()
        
        return book
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let booksURL = documentsDir.appendingPathComponent("books.plist")
        
        return booksURL
    }
    
    // Update function #1
    func updateHasBeenRead(for book: Book) {
        if book.hasBeenRead == true {
            book.hasBeenRead = false
        } else {
            book.hasBeenRead = true
        }
    }
    
    // Update function #2
    func editBook(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
    // Delete function
    func deleteBook(book: Book) -> Book {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
    }
    
    // Saving Function
    
    func saveToPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: fileURL)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        
        do {
            let booksData = try Data(contentsOf: fileURL)
            
            let decoder = PropertyListDecoder()
            
            let booksArray = try decoder.decode([Book].self, from: booksData)
            
            self.books = booksArray
        } catch {
            print("Error loading books from plist: \(error)")
        }
    }
    
    
}
