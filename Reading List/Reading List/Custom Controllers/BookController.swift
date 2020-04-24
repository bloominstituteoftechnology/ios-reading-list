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
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
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
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        var newBook = book
        if let index = books.firstIndex(of: book) {
            if newBook.hasBeenRead == true {
                newBook.hasBeenRead = false
            } else if newBook.hasBeenRead == false {
                newBook.hasBeenRead = true
            }
            books[index] = newBook
        }
        saveToPersistentStore()
    }

    
    func editBook(book: Book, with title: String, reasonToRead: String) {
        var editedBook = book
        if let index = books.firstIndex(of: book) {
            editedBook.title = title
            editedBook.reasonToRead = reasonToRead
            books[index] = editedBook
        }
        saveToPersistentStore()
    }
    
}
