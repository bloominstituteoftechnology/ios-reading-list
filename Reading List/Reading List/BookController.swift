//
//  BookController.swift
//  Reading List
//
//  Created by patelpra on 5/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        self.loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []
    
    private var readingListFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return self.books.filter { ($0.hasBeenRead == true) }
    }
    
    var unreadBooks: [Book] {
        return self.books.filter { ($0.hasBeenRead == false) }
    }
       
    // CRUD (Create, Read, Update, Delete)
    func createBook(withTitle title: String, withReasonToRead reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistenStore()
    }
    
    func deleteBook(withBook book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistenStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistenStore()
    }
    
    func updateBook(for book: Book, withTitle title: String, withReasonToRead reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistenStore()
    }

    // Save to disk
    func saveToPersistenStore() {
        guard let url = self.readingListFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving books data: \(error)")
        }
    }
 
    // Load from disk
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            self.books = try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            NSLog("Error loading books data: \(error)")
        }
        
        
    }
    
    
    

    
    

    
    
    
}
