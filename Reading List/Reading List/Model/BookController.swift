//
//  BookController.swift
//  Reading List
//
//  Created by Rob Vance on 2/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // private set means that "books" can only be set by the BookController itself
        var books: [Book] = []
        
        var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let listURL = documents.appendingPathComponent("ReadingList.plist")
            return listURL
//        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let booksdata = try encoder.encode(books)
            try booksdata.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
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
    
    // Update meathods for if book has been read or not
    func updateHasBeenRead(for book: Book) {
        guard let updateRead = books.firstIndex(of: book) else { return }
        books[updateRead].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    // Editing the books title and reasonToRead properties
    func titleAndReasonToRead (for book: Book) {
        guard let titleOrReason = books.firstIndex(of: book) else { return }
        books[titleOrReason].title = book.title
        books[titleOrReason].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    // placeholders for values passed into closures. Labeled by position instead of being named. $0 is the first argument
    var hasBeenRead: [Book] {
        return books.filter {$0.hasBeenRead == true}
    }
    var hasNotBeenRead: [Book] {
        return books.filter {$0.hasBeenRead == false}
    }
    func editBook(book: Book, title: String) {
        guard let bookToEdit = books.firstIndex(of: book) else { return }
        var tempBook = book
        tempBook.title = book.title
        books.remove(at: bookToEdit)
        books.insert(tempBook, at: bookToEdit)
        
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
