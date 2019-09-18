//
//  BookController.swift
//  Reading List
//
//  Created by Jesse Ruiz on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books : [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func createBook(titled title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(titled title: String, reasontToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasontToRead)
        books.removeLast()
        saveToPersistentStore()
        return book
    }
    
    func updateHasBeenRead(for book: Book) {
        var updateBook = book.hasBeenRead
        updateBook.toggle()
    }
    
    func editBook(for book: String, reasontoRead: String) {
        var editBook = book
        editBook = ""
        var editReason = reasontoRead
        editReason = ""
    }
    //  TODO: Will have to fix later.
    
    var readBooks: [Book] {
        let readFilter = books.filter { $0.hasBeenRead == true }
        return readFilter
    }
    
    var unreadBooks: [Book] {
        let unreadFilter = books.filter { $0.hasBeenRead == false }
        return unreadFilter
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}


