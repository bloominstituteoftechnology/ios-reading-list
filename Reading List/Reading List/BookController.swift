//
//  BookController.swift
//  Reading List
//
//  Created by Jordan Christensen on 8/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        let read = books.filter { $0.hasBeenRead == true }
        return read
    }
    var unreadBooks: [Book] {
        let unread = books.filter { $0.hasBeenRead == false }
        return unread
    }
    
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("books.plist")
    }
    
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
        
        return book
    }
    
    func deleteBook(book: Book) {
        books.remove(at: bookIndex(book: book))
        saveToPersistentStore()
    }
    
    func bookIndex(book: Book) -> Int {
        return books.firstIndex(of: book) ?? -1
    }
    
    func updateHasBeenRead(for book: Book) {
        books[bookIndex(book: book)].hasBeenRead = !books[bookIndex(book: book)].hasBeenRead
    }
    
    func setTitleReasonToRead(bookToUpdate: Book, _ title: String, _ reasonToRead: String) {
        var book = bookToUpdate
        let index = bookIndex(book: bookToUpdate)
        if !title.isEmpty {
            book.title = title
        }
        
        if !reasonToRead.isEmpty {
            book.reasonToRead = reasonToRead
        }
        books[index] = book
    }
    
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
