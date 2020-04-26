//
//  BookController.swift
//  Reading List
//
//  Created by Josh Kocsis on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
     var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
     var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("ReadingList.plist")
    }
    
     func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("There was an error saving the book data: \(error)")
        }
    }
    
     func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let bookData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: bookData)
        } catch {
            NSLog("There was an error loading your data: \(error)")
        }
        
    }
    
    @discardableResult func create(title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        self.saveToPersistentStore()
        return book
    }
    
     func delete(book: Book) {
        guard let book = books.firstIndex(of: book) else { return }
        books.remove(at: book)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let book = books.firstIndex(of: book) else { return }
        books[book].hasBeenRead = !books[book].hasBeenRead
        saveToPersistentStore()
    }
    
    func update(for book: Book, title: String, reasonToRead: String) {
        if let book = books.firstIndex(of: book) {
            books[book].title = title
            books[book].reasonToRead = reasonToRead
        }
        saveToPersistentStore()
    }
}
