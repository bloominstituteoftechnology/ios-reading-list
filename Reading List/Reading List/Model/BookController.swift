//
//  BookController.swift
//  Reading List
//
//  Created by Mark Poggi on 3/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(name: String, reasonToRead: String) {
        let book = Book(title: name, reasonToRead: reasonToRead)
        
        books.append(book)  // store the book in an array above.
        
        saveToPersistentStore() // save our book to the file.
        
    }
    
    func delete(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)
        
        saveToPersistentStore()
        
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasBeenRead = !books[index].hasBeenRead
        
        saveToPersistentStore()
    }
    
    func update(book: Book, withTitle title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        
        var scratch = book
        
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.insert(scratch, at: index)
    }
    
    
    //MARK: - Persistence/Private Methods
    
    // Where are we goint to save and load our books from?  We create a computed property rather than hard coding as iOS moves files around.  This means we never have a broken link/URL.
    
    
    
    private func saveToPersistentStore() {
        
        
        // Create the encoder
        let encoder = PropertyListEncoder()
        
        do {
            
            // Encode the books into a plist
            let booksData = try encoder.encode(books)
            
            // Grab the location we want to save the plist to.
            guard let persistentFileURL = readingListURL else { return }
            
            // Save the file to the documents directory
            try booksData.write(to: persistentFileURL)
            
        } catch {
            // Handle the error that gets "thrown" here.  iOS interpolates the error for you here.
            // This catch statement will only run if a throwing method fails.
            NSLog("Error encoding memories to property list: \(error)")
        }
        
    }
    
    private func loadFromPersistentStore() {
        
        do {
            guard let persistentFileURL = readingListURL else { return }
            
            // Create the decoder
            let decoder = PropertyListDecoder()
            
            // Grab the data (plist)
            let booksData = try Data(contentsOf: persistentFileURL)
            
            // Plist -> [Book]
            let books = try decoder.decode([Book].self, from: booksData)
            
            self.books = books
            
        } catch {
            NSLog("Error decoding memories from property list: \(error)")
        }
    }
    
    // MARK: - Properties
    
    private var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        // Grab the app's documents directory - ex. MyUser/Documents/
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // Create a unique location for the books property list (plist)
        let booksURL = documentsDir?.appendingPathComponent("books.plist")
        
        return booksURL
    }
    
    private(set) var books: [Book] = []

    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
}
