//
//  BookController.swift
//  Reading List
//
//  Created by David Williams on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("readingList.plist")
    }
    
    func saveToPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error writing to books data: \(error)")
        }
    }
    
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let booksData = try Data(contentsOf: url)
            let decodeBooks = PropertyListDecoder()
            books = try decodeBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    @discardableResult func createBook(named name: String, reasonToRead: String, hasBeenRead: Bool = false) -> Book {
        let book = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(which book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    
    func editBook(book: Book,_ title: String? = nil, reason: String? = nil) {
        guard let index = books.firstIndex(of: book) else { return }
        if let title = title {
            books[index].title = title
        }
        if let reason = reason {
            books[index].reasonToRead = reason
        }
        saveToPersistentStore()
    }
}


