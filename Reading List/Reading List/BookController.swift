//
//  BookController.swift
//  Reading List
//
//  Created by Hunter Oppel on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: CRUD
    
    var books: [Book] = []
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        var book = books[bookIndex]
        
        book.hasBeenRead = !book.hasBeenRead
        saveToPersistentStore()
    }
    
    func updateText(for book: Book, newTitle: String?, newReason: String?) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        var book = books[bookIndex]
        
        if let title = newTitle {
            book.title = title
        }
        if let reason = newReason {
            book.reasonToRead = reason
        }
        saveToPersistentStore()
    }
    
    // MARK: - Sections
    
    var readBooks: [Book] {
        return books.filter {$0.hasBeenRead}
    }
    
    var unreadBooks: [Book] {
        return books.filter {!$0.hasBeenRead}
    }
    
    // MARK: - Persistence
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let bookURL = documentsDir?.appendingPathComponent("book.plist")
        
        return bookURL
    }
    
    func saveToPersistentStore() {
        guard let bookURL = readingListURL else { return }

        do {
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: bookURL)
        } catch {
            print("Error encoding data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let bookURL = readingListURL else { return }
        
        do {
            let decoder = PropertyListDecoder()
            
            let bookPlist = try Data(contentsOf: bookURL)
            
            let books = try decoder.decode([Book].self, from: bookPlist)
            
            self.books = books
        } catch {
            print("Error decoding data: \(error)")
        }
    }
}
