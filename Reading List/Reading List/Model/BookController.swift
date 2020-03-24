//
//  BookController.swift
//  Reading List
//
//  Created by Harmony Radley on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
        
    }
    
    // MARK: - CRUD
    
    // Create
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        
        saveToPersistentStore()
    }
    
    // Delete
    
    func delete(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    // Update
    
    func updateHasBeenRead(for book: Book) {
        
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasBeenRead = !books[index].hasBeenRead
        
        saveToPersistentStore()
    }
    
    func update(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        
        var updateBook = book
        
        updateBook.title = title
        updateBook.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.insert(updateBook, at: index)
    }
    
    
    // MARK: - Persistence
    func saveToPersistentStore() {
        
        do {
            
            let encoder = PropertyListEncoder()
            
            let readingListPlist = try encoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            
            try readingListPlist.write(to: readingListURL)
        } catch {
            print("Error saving books: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let readingListURL = readingListURL else { return }
        
        do {
            
            let decoder = PropertyListDecoder()
            
            let readingListPlist = try Data(contentsOf: readingListURL)
            
            let books = try decoder.decode([Book].self, from: readingListPlist)
            
            self.books = books
            
        } catch {
            
        }
    }
}
