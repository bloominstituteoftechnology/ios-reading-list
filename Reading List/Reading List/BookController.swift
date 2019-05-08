//
//  BookController.swift
//  Reading List
//
//  Created by Kobe McKee on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        
        let newBook = Book(titled: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)

        saveToPersistentStore()
    }
    
    func updateHasBeenRead(book: Book) {
        var updatedBook = book
        updatedBook.hasBeenRead = !book.hasBeenRead
        
        deleteBook(book: book)
        books.append(updatedBook)
        print("updated hasBeenRead")
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, title: String, reasonToRead: String) {
        deleteBook(book: book)
        
        let updatedbook = Book(titled: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(updatedbook)
        
        saveToPersistentStore()
    }
    
    
    
    private var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
        
    }
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving to disk \(error)")
        }
    }
    
    
    func loadFromPersistentStore() {

        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading from disk \(error)")
        }
  
    }
    
    var readBooks: [Book] {
        
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false}
        return unreadBooks
    }
    
    
    
}
