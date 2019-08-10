//
//  BookController.swift
//  Reading List
//
//  Created by Dillon P on 8/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
//    var readBooks: [Book] = [] {
//        // return an array of Book's using a .filter method
//    }
    
//    var unreadBooks: [Book] = [] {
//        //return an array of unread books using the .filter method
//    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    
    init() {
        loadFromPersistentStore()
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving the books data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading the books data: \(error)")
        }
    }
    
    @discardableResult func createBook(named book: String, forReason reasonToRead: String, beenRead hasBeenRead: Bool) -> Book {
        let newBook = Book(title: book, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(newBook)
        saveToPersistentStore()
        return newBook
    }
    
    func delete(book: Book) {
        
    }
    
    func updateHasBeenRead(for book: Book) {
        
        if book.hasBeenRead == true {
            // book.hasBeenRead = false
        } else if book.hasBeenRead == false {
            // book.hasBeenRead = true
        }
    }
    
    func editBook(book: Book) {
        // edit books title or reason to read properties
    }
    
    
}
