//
//  BookController.swift
//  Reading List
//
//  Created by Thomas Cacciatore on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    
    
    
    func createBook(withTitle title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        //code that will check to see if a book matches in the array (maybe using first index of)
        //removes the book once we find the match
        //save to persistent store
    }
    
    func updateHasBeenRead(for book: Book) {
        var toggleRead = book.hasBeenRead
        toggleRead.toggle()
    }
    
    func updateTitleOrReason() {
        //code
        
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error: \(error)")
        }
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("book.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
}
