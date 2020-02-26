//
//  BookController.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0 .hasBeenRead }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0 .hasBeenRead == false }
    }
    
    // MARK: - Persistent Store
    
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
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return }
        
        do {
            let decodedBooks = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: decodedBooks)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    // MARK: - CRUD
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateReasonToRead(for book: Book, newReasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].reaasonToRead = newReasonToRead
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    
}
