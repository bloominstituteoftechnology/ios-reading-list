//
//  BookController.swift
//  Reading List
//
//  Created by Ilgar Ilyasov on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    
    private(set) var books = [Book]()
    
    // MARK: - Computed properties
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let fileName = "ReadingList.plist"
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    var readBooks: [Book] {
        let allReadBooks = books.filter{ $0.hasBeenRead == true }
        return allReadBooks
    }
    
    var unreadBooks: [Book] {
        let allUnreadBooks = books.filter{ $0.hasBeenRead == false }
        return allUnreadBooks
    }
    
    // MARK: - Initializer
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - Persistance functions
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let unwrappedReadingListURL = readingListURL else { return }
        
        do {
            let booksDate = try encoder.encode(books)
            try booksDate.write(to: unwrappedReadingListURL)
            
        } catch {
            NSLog("Error saving data to persistent store: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        do {
            guard let unwrappedReadingListURL = readingListURL else { return }
            let booksData = try Data(contentsOf: unwrappedReadingListURL)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: booksData)
            books = decodeBooks
        } catch {
            NSLog("Error loading data from persistent store: \(error)")
        }
    }
    
    // MARK: - CRUD methods
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        let newBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(newBook)
        
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        
        saveToPersistentStore()
    }
    
    func modifyBook(book: Book, tite: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = tite
        books[index].reasonToRead = reasonToRead
    }
    
}
