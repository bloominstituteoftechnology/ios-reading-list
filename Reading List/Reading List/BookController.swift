//
//  BookController.swift
//  Reading List
//
//  Created by Blake Andrew Price on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books = [Book]()
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        var bookHBR = book
        bookHBR.hasBeenRead.toggle()
    }
    
    func updateBook(for book: Book) {
        var bookAndOr = book
        bookAndOr.title = ""
        bookAndOr.reasonToRead = ""
    }
    
    func listBooks() -> String {
        var output = ""
        for book in books {
            output += "\(book.title) is \(book.reasonToRead).\n"
        }
        return output
    }
    // MARK: - Persistence
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL,
            fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        }  catch {
            print("Error loading books data: \(error)")
        }
    }
    // MARK: - Computed Properties
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
}


