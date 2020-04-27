//
//  BookController.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    var books: [Book] = []
    
    // Access user's documents & create a plist
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead }
    }
    
    var unreadBooks: [Book] {
        return books.filter { !$0.hasBeenRead }
    }
    
    func saveToPersistentStore() {
        // Books Array -> Data -> Write to plist file
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: readingListURL!)
        } catch {
            NSLog("Error saving book data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        // Plist file -> Data -> Books Array
        let fm = FileManager.default
        guard let url = readingListURL,
            fm.fileExists(atPath: url.path) else { return }
        // Plist file -> Data -> Books
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
    
    func createBook(bookTitle: String, reasonToRead: String) {
        let newBook = Book(title: bookTitle, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func deleteBook(bookToDelete: Book) {
        guard let index = books.index(of: bookToDelete) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
    }
    
    func updateBookInfo(for book: Book, newTitle: String, newReasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        if newTitle != "" && newReasonToRead != "" {
            books[index].title = newTitle
            books[index].reasonToRead = newReasonToRead
        } else if newTitle != "" {
            books[index].title = newTitle
        } else if newReasonToRead != "" {
            books[index].reasonToRead = newReasonToRead
        }
        saveToPersistentStore()
    }
    
}
