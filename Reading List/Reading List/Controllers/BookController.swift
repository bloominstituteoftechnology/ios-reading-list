//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_259 on 2/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: Properties
    private(set) var books: [Book] = []
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documents.appendingPathComponent("books.plist")
    }
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: data)
            books = decodeBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, newTitle: String?, newReason: String?) {
        guard let index = books.index(of: book) else { return }
        if let newTitle = newTitle {
            books[index].title = newTitle
        }
        if let newReason = newReason {
            books[index].reasonToRead = newReason
        }
    }
    
    
}
