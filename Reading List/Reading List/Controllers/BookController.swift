//
//  BookController.swift
//  Reading List
//
//  Created by Rob Vance on 4/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let listURL = documents.appendingPathComponent("ReadingList.plist")
        return listURL
    }
    init() {
        loadFromPresistentStore()
    }
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    func loadFromPresistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
// CRUD
    // Creating a book
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    // Deleting a book
    func deleteBook(with book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    // Update methods for book that has been read or not
    func updateHasBeenRead(for book: Book) {
        guard let updateRead = books.firstIndex(of: book) else { return }
        books[updateRead].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    // Editing books information
    func titleAndReasonToRead(for book: Book) {
        guard let titleOrReason = books.firstIndex(of: book) else { return }
        books[titleOrReason].title = book.title
        books[titleOrReason].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    // Placeholders for values passed into closures. Labeled by position instead of being named .$0 is the first argument
    var hasBeenRead: [Book] {
        return books.filter {$0.hasBeenRead == true}
    }
    var hasNotBeenRead: [Book] {
        return books.filter {$0.hasBeenRead == false}
    }
    func editBook(book: Book, title: String) {
        guard let index = books.firstIndex(of: book) else { return }
        var tempBook = book
        tempBook.title = book.title
        books.remove(at: index)
        books.insert(tempBook, at: index)
        saveToPersistentStore()
    }
    func update(book: Book, with title: String, and reasonToRead: String?) {
        if let index = books.firstIndex(of: book) {
            var book = books[index]
            book.title = title
            if let reasonToRead = reasonToRead {
                book.reasonToRead = reasonToRead
            }
            saveToPersistentStore()
        }
    }
}

