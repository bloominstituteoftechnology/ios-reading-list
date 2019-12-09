//
//  BookController.swift
//  Reading List
//
//  Created by David Wright on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter( { $0.hasBeenRead } )
    }
    
    var unreadBooks: [Book] {
        return books.filter( { !$0.hasBeenRead } )
    }
    
    // MARK: - CRUD Methods
    
    @discardableResult func createBook(withTitle title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(withTitle title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        } else {
            print("WARNING: Could not delete book. The book \"\(book.title)\" was not found in BookController.books")
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        } else {
            print("WARNING: Could not update book using updateHasBeenRead(for book: \"\(book.title)\"). The book \"\(book.title)\" was not found in BookController.books")
        }
    }
    
    func updateProperties(for book: Book, newTitle title: String? = nil, newReasonToRead reasonToRead: String? = nil) {
        if let index = books.firstIndex(of: book) {
            if let title = title {
                books[index].title = title
            }
            if let reasonToRead = reasonToRead {
                books[index].reasonToRead = reasonToRead
            }
            saveToPersistentStore()
        } else {
            print("WARNING: Could not update book using updateProperties(for book: \"\(book.title)\", newTitle: , newReasonToRead: ). The book \"\(book.title)\" was not found in BookController.books")
        }
    }

    // MARK: - Persistence
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving books data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        do {
            let fm = FileManager.default
            guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: data)
            books = decodeBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
}
