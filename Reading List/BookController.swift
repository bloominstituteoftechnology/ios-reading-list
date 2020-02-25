//
//  BookController.swift
//  Reading List
//
//  Created by Shawn Gee on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

private let fileName = "ReadingList.plist"

class BookController {
    private(set) var books = [Book]()
    var readBooks: [Book] { self.books.filter{ $0.hasBeenRead } }
    var unreadBooks: [Book] { self.books.filter{ !$0.hasBeenRead } }
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: - CRUD
    
    func createBook(withTitle title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        books.removeAll{ $0 == book }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        var book = book
        
        book.hasBeenRead.toggle()
        
        books[index] = book
        saveToPersistentStore()
    }
    
    func update(book: Book, title: String? = nil, reasonToRead: String? = nil) {
        guard let index = books.firstIndex(of: book) else { return }
        var book = book
        
        if let title = title {
            book.title = title
        }
        
        if let reasonToRead = reasonToRead {
            book.reasonToRead = reasonToRead
        }
        
        books[index] = book
        saveToPersistentStore()
    }
    
    
    
    //MARK: - Persistence
    
    private var readingListURL: URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    private func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        do {
            let booksPlist = try encoder.encode(books)
            try booksPlist.write(to: readingListURL)
        } catch {
            print("Couldn't save books to persistent store, error: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        
        do {
            let booksData = try Data(contentsOf: readingListURL)
            books = try decoder.decode([Book].self, from: booksData)
        } catch  {
            print("Couldn't load books from persistent store, error: \(error)")
        }
    }
}
