//
//  BookController.swift
//  Reading List
//
//  Created by Tobi Kuyoro on 17/12/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readBooks: [Book] {
       return books.filter{ $0 .hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
       return books.filter { $0 .hasBeenRead == false }
    }
    
    func createBook(called name: String, about description: String) {
        let book = Book(title: name, reasonToRead: description)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    func deleteBook(called name: String, about description: String) {
        let book = Book(title: name, reasonToRead: description)
        if let bookToDelete = books.index(of: book) {
            books.remove(at: bookToDelete)
            
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.index(of: book) {
            books[index].hasBeenRead.toggle()
            
            saveToPersistentStore()
        }
    }
    
    func updateBookInformation(for book: Book) {
        if let index = books.index(of: book) {
            books[index].title = ""
            books[index].reasonToRead = ""
            
            saveToPersistentStore()
        }
    }
    
    var readListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let booksURL = documentsDir.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        guard let fileURL = readListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: fileURL)
        } catch {
            print("Error saving stars: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let fileURL = readListURL else { return }
        do {
            let booksData = try Data(contentsOf: fileURL)
            
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch {
            print("Error loading from plist: \(error)")
        }
    }
}
