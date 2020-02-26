//
//  BookController.swift
//  Reading List
//
//  Created by Lydia Zhang on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
class BookController {
    var books: [Book] = []
    lazy var readBooks = books.filter { $0.hasBeenRead == true }
    lazy var unreadBooks = books.filter { $0.hasBeenRead == false }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let readingListURL = docDir?.appendingPathComponent("readingList.plist")
        
        return readingListURL
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let readingListPlist = try encoder.encode(books)
            guard let readingListURL = readingListURL else {
                return
            }
            try readingListPlist.write(to: readingListURL)
        } catch {
            print("Unable to save: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let readingListURL = readingListURL else {
            return
        }
        let decoder = PropertyListDecoder()
        do {
            let booksData = try Data(contentsOf: readingListURL)
            let bookArray = try decoder.decode([Book].self, from: booksData)
            self.books = bookArray
        } catch {
            print("Unable to load: \(error)")
        }
    }
    
    func createBook(with name: String, reason: String, hasBeenSeen: Bool) {
        let book = Book(title: name, reason: reason, hasBeenRead: hasBeenSeen)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        if let findBook = books.firstIndex(of: book) {
            books.remove(at: findBook)
        }
    }
    
    func updateHasBeenRead(for book: Book) -> Book {
        var book = book
        book.hasBeenRead = !book.hasBeenRead
        return book
    }
    
    func updateBookTitle(for book: Book) {
        if let changedBook = books.firstIndex(of: book) {
            books[changedBook] = book
        }
    }
}
