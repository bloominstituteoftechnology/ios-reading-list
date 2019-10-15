//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_204 on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books = [Book]()
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(titleOf title: String, reason reasonToRead: String, hasRead hasBeenRead: Bool) {
        let book = Book(title, reasonToRead, hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(_ book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        if (book.hasBeenRead) {
            books[bookIndex].hasBeenRead = false
        } else {
            books[bookIndex].hasBeenRead = true
        }
        saveToPersistentStore()
    }
    
    func updateTitleAndReason(for book: Book, updateTitle title: String, updateReason reason: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        books[bookIndex].title = title
        books[bookIndex].reasonToRead = reason
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }
    
    // Persistence
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let filename = "ReadingList.plist"
        return dir.appendingPathComponent(filename)
    }
        
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL,
            fm.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
