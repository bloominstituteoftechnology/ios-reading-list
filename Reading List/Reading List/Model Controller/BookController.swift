//
//  BookController.swift
//  Reading List
//
//  Created by Aaron Cleveland on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter{ $0 .hasBeenRead == true}
    }
    
    var unreadBooks: [Book] {
        return books.filter{ $0 .hasBeenRead == false}
    }
    
    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let bookURL = documentsDir.appendingPathComponent("books.plist")
        return bookURL
    }
    
    //MARK: Create
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        self.books.append(book)
        saveToPersistentStore()
        return book
    }
    
    //MARK: Read
    func loadFromPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        do {
            let booksData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let booksArray = try decoder.decode([Book].self, from: booksData)
            self.books = booksArray
        } catch {
            print("Error loading books from plist: \(error)")
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.index(of: book) {
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    }
    
    func updateBookInformation(book: Book, title: String, reasonToRead: String) {
        if let index = books.index(of: book) {
            books[index].title = ""
            books[index].reasonToRead = ""
            saveToPersistentStore()
        }
    }
    
    func deleteBook(book: Book) {
        self.books.removeAll { $0.title == book.title }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let bookData = try encoder.encode(books)
            try bookData.write(to: fileURL)
        } catch {
            print("Error Saving Books: \(error)")
        }
    }
}
