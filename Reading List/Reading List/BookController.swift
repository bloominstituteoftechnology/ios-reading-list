//
//  BookController.swift
//  Reading List
//
//  Created by Alex Shillingford on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // MARK: - Variables
    var books: [Book] = []
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book]? {
        let booksRead = books.filter({ $0.hasBeenRead == true })
        return booksRead
    }
    
    var unreadBooks: [Book]? {
        let booksNotRead = books.filter({ $0.hasBeenRead == false })
        return booksNotRead
    }
    
    // MARK: - Persistence
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error storing books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books from data: \(error)")
        }
    }
    
    // MARK: - CRUD Methods
    func createBook(title: String, reason: String) {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        for index in 0..<books.count {
            if book.title == books[index].title {
                books[index].hasBeenRead.toggle()
            }
        }
    }
    
    func updateBook(book: Book, withTitle title: String, reasonToRead: String) {
        let updatedBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: book.hasBeenRead)
        guard let book = books.firstIndex(of: book) else { return }
        books[book] = updatedBook
    }
    
    
}
