//
//  BookController.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol manageBookDelegate {
    func updateBook (book: Book, title: String?, reason: String?)
    func createBook (title: String, reason: String)
}

protocol createBookDelegate {
    
}

class BookController {
    private(set) var books: [Book] = []
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
    @discardableResult func create(titled title: String, withReason reason: String, _ beenRead: Bool = false) -> Book {
        let book = Book(title: title, reasonToRead: reason, hasBeenRead: beenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func delete(which book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }

    
    func toggleHasBeenRead (which book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].toggleHasBeenRead()
        saveToPersistentStore()
    }
    
    func update(which book: Book, _ title: String? = nil, _ reason: String? = nil) {
        guard let index = books.firstIndex(of: book) else { return }
        if let title = title {
            books[index].title = title
        }
        if let reason = reason {
            books[index].reasonToRead = reason
        }
    }
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // /Users/paulsolt/Documents
        // /Users/paulsolt/Documents/stars.plist
        
        return documents.appendingPathComponent("books.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
    
}
