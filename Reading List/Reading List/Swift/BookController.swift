//
//  BookController.swift
//  Reading List
//
//  Created by Bobby Keffury on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }
    
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    
    
    
    
    func createBook(named title: String, with reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    
   
    func deleteBook(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books[index].hasBeenRead = !books[index].hasBeenRead
            saveToPersistentStore()
        }
    }
    
    func updateBook(for book: Book, with title: String, and reasonToRead: String) {
        if let index = books.firstIndex(of: book) {
            books[index].title = title
            books[index].reasonToRead = reasonToRead
            saveToPersistentStore()
        }
    }
    
    
    
    
    
    
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
        
    }
    
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
        
    }
    
    
    
    
    
}
