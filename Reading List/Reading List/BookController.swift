//
//  BookController.swift
//  Reading List
//
//  Created by Kat Milton on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    private(set) var readBooks: [Book] = []
        
    
    
    // Creating computed property.
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    // MARK: - CRUD Methods
    
    // Creates a book and appends it to the array.
    func createBook(named title: String, withReason reason: String) {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
    }
    
    // Removes a book from the array.
    func deleteBook(remove book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
    }
    
    // Updates the hasBeenRead value on the book in the array.
    func updateHasBeenRead(for book: Book) {
        if let index = books.index(of: book) {
            books[index].hasBeenRead.toggle()
        }
    }
    
    // Allows updating of book title or reason to read.
    func editBookInfo(edit book: Book) {
//        if let index = books.index(of: book) {
//            var newTitle: String
//            books[index].title = newTitle
//        }
    }
    
    // Filtering read books.
    func filterBooks() {
        
    }
    
    
    
    
    // Saving to computed property.
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving reading list data: \(error)")
        }
        
    }
    
    // Loading from persistent data.
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading reading list data: \(error)")
        }
    }
    
}

