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
    
    
    // Creating computed property.
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("readingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    var readBooks: [Book] {
        get {
            return BookController().books.filter() {
            $0.hasBeenRead == true
        }
    }
    }
    
    var unreadBooks: [Book] {
        get {
        return BookController().books.filter() {
            $0.hasBeenRead == false
            }
        }
        
    }
    // MARK: - CRUD Methods
    
    // Creates a book and appends it to the array.
    func createBook(named title: String, withReason reason: String) {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    // Removes a book from the array.
    func deleteBook(remove book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    // Updates the hasBeenRead value on the book in the array.
    func updateHasBeenRead(for book: Book) {
        var updatedReadBook = book
        updatedReadBook.hasBeenRead = !book.hasBeenRead
        
        deleteBook(remove: book)
        books.append(updatedReadBook)
        saveToPersistentStore()

    }
    
    // Allows updating of book title or reason to read.
    func editBookInfo(edit book: Book, title: String, reasonToRead: String) {
        deleteBook(remove: book)
        let updatedBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(updatedBook)
        saveToPersistentStore()

    }
    
  
    
    // MARK: - Computing functions
        
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
