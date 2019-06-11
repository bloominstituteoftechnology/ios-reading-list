//
//  BookController.swift
//  Reading List
//
//  Created by Alex Shillingford on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // MARK: - properties
    var books: [Book] = []
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        // Creates "/Users/shillwil/Documents" - documents directory path
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return nil }
        
        // Creates "/Users/shillwil/Documents/books.plist" - full file path
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    private var readBooks: [Book] {
        return books.filter({ (book: Book) -> Bool in book.hasBeenRead == true })
    }
    
    private var unreadBooks: [Book] {
        return books.filter({ (book: Book) -> Bool in book.hasBeenRead == false })
    }
    
    // MARK: - Methods manipulating Books
    func createBook(named name: String, why reason: String, _ hasBeenRead: Bool) {
        let book = Book(title: name, reasonToRead: reason, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        for index in 0..<books.count {
            if book.title == books[index].title {
                books.remove(at: index)
            }
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        for index in 0..<books.count {
            if book.title == books[index].title {
                books[index].hasBeenRead = !books[index].hasBeenRead
            }
        }
    }
    
    func updateTitleOrReason(for book: Book) {
        // COME BACK AND EDIT THIS
    }
    
    // MARK: - Persistence storing/updating data methods
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
    
    func loadToPersistentStore() {
        
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
