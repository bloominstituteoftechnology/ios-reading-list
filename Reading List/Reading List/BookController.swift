//
//  BookController.swift
//  Reading List
//
//  Created by Ian Becker on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        
    }
    
    func updateHasBeenRead(for book: Book) {
        
    }
    
    func editBook() {
        
    }
    
    var readBooks: [Book] {
        
    }
    
    var unreadBooks: [Book] {
        
    }
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let readingListURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return readingListURL
    }
    func saveToPersistentStore() {
        
        do {
            
            guard let persistentFileURL = readingListURL else { return }
            
            let encoder = PropertyListEncoder()

            let booksData = try encoder.encode(books)
            
            try booksData.write(to: persistentFileURL)
            
            
        } catch {
            print("Error saving books: \(error)")
        }
    }
    func loadFromPersistentStore() {
        do {
            
            guard let persistentFileURL = readingListURL else { return }
            
            let booksData = try Data(contentsOf: persistentFileURL)
            
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error loading books from plist: \(error)")
        }
    }
}
