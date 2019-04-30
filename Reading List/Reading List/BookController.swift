//
//  BookController.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController{
    
    //When this is called a new book is added to the books array
    func createBook(titled title: String, withReason reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPerisitentStore()
    }
    
    //when this is called a book is deleted from the array
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPerisitentStore()
    }
    
    //changes the hasBeenRead of a book to true or false
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        var updatedBook = books[bookIndex]
        
        
        
        if updatedBook.hasBeenRead == false {
            updatedBook.hasBeenRead = true
        } else {
            updatedBook.hasBeenRead = false
        }
        saveToPerisitentStore()
    }
    
    func updateBook(book: Book, withTitle title:String, reasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        var book = books[bookIndex]
        book.title = title
        book.reasonToRead = reasonToRead
        books.remove(at: bookIndex)
        books.insert(book, at: bookIndex)
        
        saveToPerisitentStore()
    }
    
    
    
    // Save to disk
    func saveToPerisitentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving stars: \(error)")
        }
    }
    
    
    // Load from the disk
    func loadFromPersistentStore() {
        // Make sure file exists
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            print("load failed to find file")
            return }
        
        // Load and decode
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    private var readBooks: [Book]? {
        return books.filter({ $0.hasBeenRead == true})
    }
    
    private var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false})
    }
    
    private(set) var books: [Book] = []
    
    
}

