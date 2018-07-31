//
//  BookController.swift
//  Reading List
//
//  Created by Linh Bouniol on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
        
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    private var readingListURL: URL? {
        // Get user's document directory
        let fm = FileManager.default
        
        guard let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    func createBook(withTitle title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        // Get index of book we're interested in
        if let index = books.index(of: book) {
            var book = book
            book.hasBeenRead = !book.hasBeenRead
            
            books.remove(at: index)
            books.insert(book, at: index)
        }
        
        saveToPersistentStore()
    }
    
    func update(book: Book, title: String, reasonToRead: String) {
        if let index = books.index(of: book) {
            var book = book
            book.title = title
            book.reasonToRead = reasonToRead
            
            books.remove(at: index)
            books.insert(book, at: index)
        }
        
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            // Pass in the books and get the data
            let booksData = try encoder.encode(books)
            
            // Write the data to disk
            try booksData.write(to: url)
            
        } catch {
            NSLog("Error saving books data \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        
        do {
            guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
            
            // Get the data
            let data = try Data(contentsOf: url)
            
            // Initialize a PropertyListDecoder
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: data)
            
        } catch {
            NSLog("Error saving books data \(error)")
        }
    }
}
