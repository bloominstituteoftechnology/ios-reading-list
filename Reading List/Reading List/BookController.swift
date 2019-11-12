//
//  BookController.swift
//  Reading List
//
//  Created by Tobi Kuyoro on 12/11/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readBooks: [Book] {
        self.readBooks.filter {
            $0 .hasBeenRead == true
        }
    }
    
    var unreadBooks: [Book] {
        self.readBooks.filter {
            $0 .hasBeenRead == false
        }
    }
    
    func createBook(called title: String, readItBecause reason: String) -> Book {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
        
        return book
    }
    
    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateBookInfo(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].title = ""
        books[bookIndex].reasonToRead = ""
    }
    
    // MARK: - Persistence
    
    var readingListURL: URL? {
        let fileManager = FileManager()
        
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            try booksData.write(to: readingListURL)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistence() {
        do {
            guard let readingListURL = readingListURL else { return }
            let booksData = try Data(contentsOf: readingListURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error saving books: \(error)")
        }
    }
}
