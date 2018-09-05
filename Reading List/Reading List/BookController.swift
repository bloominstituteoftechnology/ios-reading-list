//
//  BookController.swift
//  Reading List
//
//  Created by Moin Uddin on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)        
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateBookDetails(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        var newBook = book
        newBook.title = title
        newBook.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(newBook, at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(book: Book) {
        guard let index = books.index(of: book) else { return }
        var newBook = book
        newBook.hasBeenRead = !book.hasBeenRead
        books.remove(at: index)
        books.insert(newBook, at: index)
        saveToPersistentStore()
    }
    
    
    private func saveToPersistentStore() {
        let plistEncoder = PropertyListEncoder()
        guard let readingListUrl = readingListURL else { return }
        do {
            let booksData = try plistEncoder.encode(books)
            try booksData.write(to: readingListUrl )
        } catch {
            NSLog("Error saving reading list data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        do {
            guard let readingListUrl = readingListURL, FileManager.default.fileExists(atPath: readingListUrl.path) else { return }
            let booksData = try Data(contentsOf: readingListUrl)
            let plistDecoder = PropertyListDecoder()
            self.books = try plistDecoder.decode([Book].self, from: booksData)
        } catch {
            NSLog("Error loading reading list data: \(error)")
        }
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent("Reading-List.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { (book) -> Bool in
            book.hasBeenRead
        }
    }
    
    var unreadBooks: [Book] {
        return books.filter { (book) -> Bool in
            !book.hasBeenRead
        }
    }
    private(set) var books: [Book] = []
}
