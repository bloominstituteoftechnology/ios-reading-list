//
//  BookController.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func createABook(with title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    // "Delete" method
    func deleteBook(book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    // Two "Update" methods
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    }
    
    func updateTitle(for book: Book, with title: String, and reasonToRead: String?) {
        if let index = books.firstIndex(of: book) {
            var book = books[index]
            book.title = title
            if let reasonToRead = reasonToRead {
                book.reasonToRead = reasonToRead
            }
            saveToPersistentStore()
        }
    }
    
    // computed property
    
    var readBooks: [Book] {
        let read = books.filter { return $0.hasBeenRead }
        return read
    }
    
    var unreadBooks: [Book] {
        let unread = books.filter { return !$0.hasBeenRead }
        return unread
    }
    
    
    // MARK: - Persistence
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        // Covert Stars into a Property List
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let booksData = try encoder.encode(books)
            
            guard let booksURL = readingListURL else { return }
            
            try booksData.write(to: booksURL)
            
        } catch {
            // The catch statement gets called if the functions(s) that you call "try" on fails.
            print("Unable to save books to plist: \(error)")
            
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let booksURL = readingListURL else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            // Goes to the starsURL and grab the file (data) from that location
            let booksData = try Data(contentsOf: booksURL)
            
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error decoding books: \(error)")
            
        }
    }
    
    
    
    
    
}
