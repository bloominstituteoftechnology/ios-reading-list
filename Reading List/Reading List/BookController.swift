//
//  BookController.swift
//  Reading List
//
//  Created by Dawn Jones on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead })
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBookData(for book: Book, title: String, reasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        var temp = book
        temp.title = title
        temp.reasonToRead = reasonToRead
        
        books.remove(at: bookIndex)
        books.insert(temp, at: bookIndex)
        
        saveToPersistentStore()
    }
}
