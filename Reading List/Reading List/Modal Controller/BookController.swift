//
//  BookController.swift
//  Reading List
//
//  Created by Michael on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        loadFromPersistentStore()
        return books.filter {$0.hasBeenRead}
        
    }
    var unreadBooks: [Book] {
        loadFromPersistentStore()
        return books.filter {$0.hasBeenRead == false}
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let booksURL = documentsDir.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        guard let bookListURL = readingListURL else { return }
        
        do {
            
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: bookListURL)
        } catch {
            print("Error saving books: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            
            guard let bookListURL = readingListURL else { return }
            
            let booksData = try Data(contentsOf: bookListURL)
            
            let decoder = PropertyListDecoder()
            
            let booksArray = try decoder.decode([Book].self, from: booksData)
            
            self.books = booksArray
        } catch {
            print("Error loading books from plist: \(error).")
        }
    }


    func create(for book: Book) {
        
        books.append(book)
        saveToPersistentStore()
    }

    func delete(for book: Book) {
        guard let bookToRemove = books.firstIndex(of: book) else { return }
        books.remove(at: bookToRemove)
        saveToPersistentStore()
    }

    func updateHasBeenRead(for book: Book) {
        guard let bookToEdit = books.firstIndex(of: book) else { return }
        books[bookToEdit].hasBeenRead = !books[bookToEdit].hasBeenRead
        saveToPersistentStore()
    }

    func editBook(for book: Book) {
        guard let bookToEdit = books.firstIndex(of: book) else { return }
        var tempBook = book
        
        tempBook.title = book.title
        tempBook.reasonToRead = book.reasonToRead
        
        books.remove(at: bookToEdit)
        books.insert(tempBook, at: bookToEdit)
        saveToPersistentStore()
    }
    
}


