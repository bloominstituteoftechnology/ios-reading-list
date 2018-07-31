//
//  BookController.swift
//  Reading List
//
//  Created by De MicheliStefano on 31.07.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // This model controller provides basic CRUD functionality for books: [Book]
    // It also provides methods to handle saving and loading from the persistent store (documents directory).
    
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.index(of: book) {
            var book = books[index]
            book.hasBeenRead = !book.hasBeenRead
            books.remove(at: index)
            books.insert(book, at: index)
        }
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, title: String, reasonToRead: String) {
        if let index = books.index(of: book) {
            var book = books[index]
            book.title = title
            book.reasonToRead = reasonToRead
            books.remove(at: index)
            books.insert(book, at: index)
        }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            // Encoding entire books array to PropertyList and write it to "disk" at readingListURL
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            if let readingListURL = readingListURL {
                try booksData.write(to: readingListURL)
            }
        } catch {
            NSLog("An error occured while saving book: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            // Decode data at path readingListURL and update books array
            let decoder = PropertyListDecoder()
            guard let readingListURL = readingListURL else { return }
            let data = try Data(contentsOf: readingListURL)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("An error occured while loading book: \(error)")
        }
    }
    
    private var readingListURL: URL? {
        // Grabing documents URL and appending filename ReadingList.plist
        let fm = FileManager()
        let fileName = "ReadingList.plist"
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent(fileName)
    }
    
    var readBooks: [Book] {
        // Return all books that have been read
        return books.filter( { $0.hasBeenRead == true } )
    }
    
    var unreadBooks: [Book] {
        // Return all books that have not yet been read
        return books.filter( { $0.hasBeenRead == false } )
    }
    
    private(set) var books = [Book]()
    
}
