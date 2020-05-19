//
//  BookController.swift
//  Reading List
//
//  Created by Richard Gibbs on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController: Codable {
    
    var books: [Book] = []
    
    
    // CRUD - What interactions will I have with my model (Star)
    
    // Read
    
    //We'll treat this initializer like a viewDidLoad() of a view controller. It's just a place where we can call some code
    
    init() {
        loadFromPersistentStore()
    }
    
    // Create
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    // Where are we going to store the stars? (Where are we going to load them from?)
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        // Get the documents directory
        
        // myApp/documents/books.plist
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // myApp/documents/books.plist
        let booksURL = documentsDir?.appendingPathComponent("books.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        do {
            
            // We can't save the stars to a file if the file location isn't valid
            guard let readingListURL = readingListURL else { return }
            
            
            // This is the machine that we can run our array of stars through to turn it into a property list
            let encoder = PropertyListEncoder()
            
            // Try to turn the stars into a property list
            let booksData = try encoder.encode(books)
            
            // Save the stars plist to the location that we specified in the persistentFileURL
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            
            // Make sure the plist file exists, or just leave the function if not
            guard let readingListURL = readingListURL else { return }
            
            // URL -> Data
            
            let booksPlist = try Data(contentsOf: readingListURL)
            
            // Data -> [Book]
            
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            
            self.books = decodedBooks
            
        } catch {
            print("Error loading books: \(error)")
            
        }
    }
    
}


