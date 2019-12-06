//
//  BookController.swift
//  Reading List
//
//  Created by Jeremy Taylor on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []

    var readingListURL: URL? {
        let fm = FileManager.default
        guard let documents = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.sorted {$0.title < $1.title }.filter {$0.hasBeenRead}
    }
    
    var unreadBooks: [Book] {
        return books.sorted {$0.title < $1.title }.filter {!$0.hasBeenRead}
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving ReadingList data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL,
            fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading ReadingList data: \(error)")
        }
    }
    
    @discardableResult func createBook(withTitle title: String, andReasonToRead reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(_ book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        var tempBook = book
        tempBook.hasBeenRead.toggle()
        books.remove(at: index)
        books.insert(tempBook, at: index)
        saveToPersistentStore()
    }
    
    func updateBook(_ book: Book, withTitle title: String, andReasonToRead reasonToRead: String ) {
        guard let index = books.firstIndex(of: book) else { return }
        var tempBook = book
        tempBook.title = title
        tempBook.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(tempBook, at: index)
        saveToPersistentStore()
    }
}
