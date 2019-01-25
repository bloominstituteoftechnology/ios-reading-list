//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_59 on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    private var readingListURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "Reading List.plist"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    // MARK: - CRUD methods
    
    func createBook(withTitle title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        
        // Sort after adding to array
        books.sort { $0.title < $1.title }
        
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        
        var book = book
        book.hasBeenRead = !book.hasBeenRead
        
        books.remove(at: index)
        books.insert(book, at: index)
        
        saveToPersistentStore()
    }
    
    func update(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        
        var book = book
        book.title = title
        book.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.insert(book, at: index)
        
        // Sort after a change is made
        books.sort { $0.title < $1.title }
        
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error savings books data \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        
        do {
            guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("Error saving books data \(error)")
        }
    }
}


