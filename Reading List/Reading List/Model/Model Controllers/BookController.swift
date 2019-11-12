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
    /// The array of model objects used within the app.
    var books = [Book]()
    
    var readBooks: [Book] {
        return books.filter( { $0.hasBeenRead == true } )
    }
    
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
    // MARK: - Instance Methods
    func create(with name: String, reason: String) {
        let book = Book(name: name, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(_ book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
    }
    
    func update(name: String?, reasonToRead: String?, for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        if let name = name {
            books[index].name = name
        }
        
        if let reason = reasonToRead {
            books[index].reasonToRead = reason
        }
        
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
