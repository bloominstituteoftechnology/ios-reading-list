//
//  BookController.swift
//  Reading List
//
//  Created by Chad Rutherford on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    /// The array of model objects used within the app. - CRUD (R)
    var books = [Book]()
    
    /// Computed property to return the read books in the app - CRUD (R)
    var readBooks: [Book] {
        return books.filter( { $0.hasBeenRead == true } )
    }
    
    /// Computed property to return the unread books in the app - CRUD (R)
    var unreadBooks: [Book] {
        return books.filter( { $0.hasBeenRead == false } )
    }
    
    /// Computed property to retrieve and store the file URL for the apps saved data
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let fileName = "ReadingList.plist"
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Initialization
    init() {
        loadFromPersistentStore()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Instance Methods
    
    /// Create a Book Object and save it to books array - CRUD (C)
    func create(with name: String, reason: String) {
        let book = Book(name: name, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    /// Remove Book object from array - CRUD (D)
    func delete(_ book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    /// Update hasBeenRead property on Book object - CRUD (U)
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
    }
    
    /// Update title and reason properties on Book object - CRUD (U)
    func update(name: String, reasonToRead: String, for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].name = name
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Persistence
    /// Function used to save model items to the plist file.
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let fileURL = readingListURL else { return }
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: fileURL)
        } catch let saveError {
            print("Error saving books to file: \(saveError.localizedDescription)")
        }
    }
    
    /// Function used to load model objects from the plist file.
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        let fileManager = FileManager.default
        guard let fileURL = readingListURL, fileManager.fileExists(atPath: fileURL.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: fileURL)
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch let loadError {
            print("Error loading books from file: \(loadError.localizedDescription)")
        }
    }
}
