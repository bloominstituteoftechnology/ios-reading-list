//
//  BookController.swift
//  Reading List
//
//  Created by Joel Groomer on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("books.plist")
    }
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    
    // MARK: - CRUD methods
    
    @discardableResult func addBook(named: String, reasonToRead: String) -> Book? {
        for book in books {
            if book.title == named {
                return nil
            }
        }
        let newBook = Book(title: named, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
        return newBook
    }
    
    func updateRead(for book: Book) -> Book {
        guard let i = books.firstIndex(of: book) else { return book }
        books[i].hasBeenRead.toggle()
        saveToPersistentStore()
        return books[i]
    }
    
    func updateBook(for book: Book, newTitle: String, newReason: String) -> Book? {
        guard let i = books.firstIndex(of: book) else {
            // if the specified book doesn't exist, just add it
            return addBook(named: newTitle, reasonToRead: newReason)
        }
        books[i].title = newTitle
        books[i].reasonToRead = newReason
        saveToPersistentStore()
        return books[i]
    }
    
    func deleteBook(_ book: Book) {
        guard let i = books.firstIndex(of: book) else { return }
        books.remove(at: i)
        saveToPersistentStore()
    }
    
    // MARK: - File I/O
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
