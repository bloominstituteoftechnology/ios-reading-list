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
        if readBooks.contains(book) {
            if let index = readBooks.firstIndex(of: book) {
                readBooks.remove(at: index)
            }
        } else if unreadBooks.contains(book) {
            if let index = unreadBooks.firstIndex(of: book) {
                unreadBooks.remove(at: index)
            }
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        var newBook = book
        if readBooks.contains(book) {
            if let index = readBooks.firstIndex(of: book) {
                readBooks.remove(at: index)
            }
            newBook.hasBeenRead = false
            unreadBooks.append(newBook)
        } else if unreadBooks.contains(book) {
            if let index = unreadBooks.firstIndex(of: book) {
                unreadBooks.remove(at: index)
            }
            newBook.hasBeenRead = true
            readBooks.append(newBook)
        }
    }
    
    func editBook(book: Book) {
//        var newBook = book
        if readBooks.contains(book) {
            if let index = readBooks.firstIndex(of: book) {
                readBooks[index] = Book(title: "Edited", reasonToRead: "testing")
            }
        } else if unreadBooks.contains(book) {
            if let index = unreadBooks.firstIndex(of: book) {
                unreadBooks[index] = Book(title: "Edited", reasonToRead: "testing")
            }
        }
    }
    
    
}
