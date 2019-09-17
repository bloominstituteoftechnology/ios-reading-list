//
//  BookController.swift
//  Reading List
//
//  Created by Isaac Lyons on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter {$0.hasBeenRead}
    }
    var unreadBooks: [Book] {
        return books.filter {!$0.hasBeenRead}
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func create(name: String, reasonToRead: String) {
        let book = Book(title: name, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
//            var newBook = books[index]
//            newBook.hasBeenRead.toggle()
//            books[index] = newBook
            // The above seemed a bit too verbose, but I'm not sure exactly which would be better.
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    }
    
    func updateBook(book: Book, newTitle: String, newReasonToRead: String) {
        if let index = books.firstIndex(of: book) {
            var newBook = books[index]
            newBook.title = newTitle
            newBook.reasonToRead = newReasonToRead
            books[index] = newBook
            saveToPersistentStore()
        }
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
