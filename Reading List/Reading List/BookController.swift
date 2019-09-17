//
//  BookController.swift
//  Reading List
//
//  Created by Gi Pyo Kim on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // MARK: properties
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    // MARK: methods
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving reading list data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
            
        } catch {
            print("Error loading book list data: \(error)")
        }
    }
    
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        if books.count > 0 {
            for i in 0...books.count-1 {
                if  books[i] == book {
                    print("\(book.title) is already in the list")
                    return
                }
            }
        }
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        for i in 0...books.count-1 {
            if  books[i] == book {
                books.remove(at: i)
                saveToPersistentStore()
            }
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        for i in 0...books.count-1 {
            if books[i] == book {
                books[i].hasBeenRead = !book.hasBeenRead
                saveToPersistentStore()
            }
        }
    }
    
    func updateBook(book: Book, title: String, reasonToRead: String) {
        for i in 0...books.count-1 {
            if books[i] == book {
                books[i].title = title
                books[i].reasonToRead = reasonToRead
                saveToPersistentStore()
            }
        }
    }
    
}
