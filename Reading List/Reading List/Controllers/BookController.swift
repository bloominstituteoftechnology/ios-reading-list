//
//  BookController.swift
//  Reading List
//
//  Created by David Williams on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol handleBookDelegate {
    func updateBook (book: Book, title: String?, reason: String?)
    func createBook (title: String, reason: String)
}


class BookController {
        
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
     var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
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
            let booksData =  try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books =  try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    @discardableResult func createBook(named name: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
            let book = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
            books.append(book)
            saveToPersistentStore()
            return book
        }
        
        init() {
            loadFromPersistentStore()
        }
    
    func deleteBook(which book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
  
    func updateHasBeenRead(for book: Book) {
        let readBooks: [Book] = books.filter {_ in book.hasBeenRead }
        let unreadBooks: [Book] = books.filter {_ in !book.hasBeenRead }
        saveToPersistentStore()
    }
  
    func updateBook(book: Book, _ title: String? = nil, reason: String? = nil) {
        guard let index = books.firstIndex(of: book) else { return }
        if let title = title {
            books[index].title = title
        }
        if let reason = reason {
            books[index].reasonToRead = reason
        }
    }
}
