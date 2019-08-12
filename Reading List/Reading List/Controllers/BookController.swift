//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Casualty on 8/11/19.
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
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks.sorted()
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks.sorted()
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func addBook(named: String, reason: String) -> Book? {
        
        let newBook = Book(title: named, reasonToRead: reason, rating: 5)
        books.append(newBook)
        saveToPersistentStore()
        return newBook
        
    }
    
    @discardableResult func updateRead(for book: Book) -> Book {
        guard let i = books.firstIndex(of: book) else { return book }
        books[i].hasBeenRead.toggle()
        saveToPersistentStore()
        return books[i]
    }
    
    func deleteBook(_ book: Book) {
        guard let i = books.firstIndex(of: book) else { return }
        books.remove(at: i)
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, bookTitle: String, bookReason: String) -> Book? {
        guard let i = books.firstIndex(of: book) else {
            return addBook(named: bookTitle, reason: bookReason)
        }
        books[i].title = bookTitle
        books[i].reasonToRead = bookReason
        saveToPersistentStore()
        return books[i]
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let loadData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: loadData)
            books = decodedBooks
        } catch {
            print("Error loading data: \(error)")
        }
    }
}
