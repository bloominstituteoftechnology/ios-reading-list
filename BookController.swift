//
//  BookController.swift
//  Reading List
//
//  Created by Andrew Ruiz on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    
    var books: [Book] = []
    
    @discardableResult func createBook(withName title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        
        if let index = books.firstIndex(of:book) { // Not sure if this will work. How to test?
            books.remove(at: index)
        }
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        
        var newBook = book
        newBook.hasBeenRead = !newBook.hasBeenRead
        
        deleteBook(book: book)
        books.append(newBook)
        
        print(books)
        
    }
    
    // MARK: - Persistence
    
    private func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving book data: \(error)")
        }
    }
    
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
    
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
}
