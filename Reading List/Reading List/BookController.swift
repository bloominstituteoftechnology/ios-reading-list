//
//  BookController.swift
//  Reading List
//
//  Created by Jeffrey Carpenter on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = [] {
        didSet {
            saveToPersistentStore()
        }
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("books.plist")
    }
    
    var readBooks: [Book] {
        
        var readBooks: [Book] = []
        
        for book in books {
            if book.hasBeenRead { readBooks.append(book) }
        }
        
        return readBooks
    }
    
    var unreadBooks: [Book] {
        
        var unreadBooks: [Book] = []
        
        for book in books {
            if !book.hasBeenRead { unreadBooks.append(book) }
        }
        
        return unreadBooks
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD Methods
    func createBook(titled title: String, withReason reason: String) {
        
        let newBook = Book(title: title, reasonToRead: reason)
        books.append(newBook)
    }
    
    func deleteBook(_ book: Book) {
        
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
    }
    
    func updateHasBeenRead(for book: Book) {
        
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
    }
    
    func updateBook(_ book: Book, newTitle title: String, newReason reason: String) {
        
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reason
    }
    
    // MARK: - Persistent Storage Methods
    func saveToPersistentStore() {
      
        let encoder = PropertyListEncoder()
        
        do {
            guard let url = readingListURL else { return }
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            fatalError("Error saving to disk: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        
        guard let url = readingListURL,
        fileManager.fileExists(atPath: url.path)
            else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            fatalError("Error reading from disk: \(error)")
        }
    }
}
