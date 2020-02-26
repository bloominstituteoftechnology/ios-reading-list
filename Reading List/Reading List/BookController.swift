//
//  BookController.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []

    // This initilizer is treated as the viewDidLoad of the model controller.
    init() {
        loadFromPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }

    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    //TODO: Does this leverage equatable? 
    func findBook(_ book: Book) -> Book? {
        let matches = books.filter { $0 == book }
        assert(matches.count == 1)
        return matches[0]
    }
    
    // MARK: - CRUD
    
    // Create
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    // Read. Not the model
    
    // Update
    func toogleHasBeenRead(book b: Book) {
        if let index = books.firstIndex(where: { $0 == b }) {
            books[index].hasBeenRead = !books[index].hasBeenRead
        }
    }
    
    // TODO: Was I correct to pass the book object back because it's a struct
    func updateTitleAndReason(book b: Book, title: String, reasonToRead: String) {
        if let index = books.firstIndex(where: { $0 == b }) {
            books[index].title = title
            books[index].reasonToRead = title
        }
    }
    
    // Delete
    func delete(book bookToDelete: Book) {
        let booksMinusBookToDelete = books.filter { $0 != bookToDelete }
        books = booksMinusBookToDelete
    }
    
    // MARK: - Persitance
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksUrl = documentsDir?.appendingPathComponent("books.plist")
        
        return booksUrl
    }
    
    func saveToPersistentStore() {
        // Convert our book Property List
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books) //FIXME: encode(value:
            
            guard let booksUrl = readingListURL else { return }
            
            try booksData.write(to: booksUrl)
            
        } catch {
            print("Unable to save books to plist: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        do {
            guard let readingListURL = readingListURL else { return }
            
            let booksData = try Data(contentsOf: readingListURL)
            
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Unable to open books to plist: \(error)")
        }
    }
}
