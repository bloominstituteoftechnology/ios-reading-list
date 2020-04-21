//
//  BookController.swift
//  Reading List
//
//  Created by Vincent Hoang on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import os.log

class BookController {
    var books: [Book] = [Book]()
    
    init() {
        loadFromPersistentStore()
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksURL = documentsDir?.appendingPathComponent("books.plist")
        
        return booksURL
    }
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead})
    }
    
    var unreadBooks: [Book] {
        return books.filter({!$0.hasBeenRead})
    }
    
    func create(_ title: String, _ reason: String) {
        let book = Book(title, reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(_ book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        guard let unwrappedReadingListURL = readingListURL else {
            fatalError("Unable to retrieve readingListURL")
        }
        
        do {
            var encodedBooks: Data
            try encodedBooks = encoder.encode(books)
            try encodedBooks.write(to: unwrappedReadingListURL)
            
            os_log("%@", log: OSLog.default, type: .debug, "New persistent entry")
        } catch {
            fatalError("Object was not of type [Book] or error writing books to persistent storage")
        }
        
    }
    
    func updateHasBeenRead(for book: inout Book) {
        book.hasBeenRead = !book.hasBeenRead
        saveToPersistentStore()
    }

    func updateBook(for book: inout Book,_ title: String,_ reason: String) {
        book.title = title
        book.reasonToRead = reason
        saveToPersistentStore()
    }
    
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        
        guard let unwrappedReadingListURL = readingListURL else {
            fatalError("Unable to retrieve readingListURL")
        }
        
        do {
            var data: Data
            
            try data = Data.init(contentsOf: unwrappedReadingListURL)
            
            try books = decoder.decode([Book].self, from: data)
            
            os_log("%@", log: OSLog.default, type: .debug, "Successfully loaded books from persistent storage. Number of books loaded: \(books.count)")
        } catch {
            fatalError("Error decoding books from persistent storage")
        }
    }

}
