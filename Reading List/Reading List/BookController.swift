//
//  BookController.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    
    
    func createBook(with title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    // "Delete" method
    func deleteBook(book: Book) {
        
        //firstindexof
        
        books.remove(at: 0)
    }
    
    // Two "Update" methods
    func updateHasBeenRead(for book: Book) {
        
        hasBeenRead.toggle()
        // indexPath
        // .toggle (for Bool)
        
    }
    
    
    func updateTitle(for book: Book) {
        
    }
    
    // computed property
    
    var readBooks: [Book] {
        
        
    }
    
    var unreadBooks: [Book] {
        
        
    }
    // MARK: - Persistence
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("books.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        // Covert Stars into a Property List
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let booksData = try encoder.encode(books)
            
            guard let booksURL = readingListURL else { return }
            
            try booksData.write(to: booksURL)
            
        } catch {
            // The catch statement gets called if the functions(s) that you call "try" on fails.
            print("Unable to save books to plist: \(error)")
            
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let booksURL = readingListURL else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            // Goes to the starsURL and grab the file (data) from that location
            let booksData = try Data(contentsOf: booksURL)
            
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error decoding books: \(error)")
            
        }
    }
    
    
    
    
    
}
