//
//  BookController.swift
//  Reading List
//
//  Created by Joshua Rutkowski on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
// MARK: - Properties
    /// Array of book objects
    var books = [Book]()
    /// Returns books that have been read
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    /// Returns book objects that have not been read
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }
    
    init() {
         loadFromPersistentStore()
     }
//MARK: - Methods
    
    /// Creates a new book object in the book array
    /// - Parameters:
    ///   - title: The title of the book
    ///   - reasonToRead: The reason to read the book
    ///   - hasBeenRead: If the book has been read
    func createBook(titleOf title: String, reason reasonToRead: String, hasRead hasBeenRead: Bool) {
         let book = Book(title, reasonToRead, hasBeenRead)
         books.append(book)
         saveToPersistentStore()
     }

    /// Removes a book object from the book array
    /// - Parameter book: Book object
     func deleteBook(_ book: Book) {
         guard let bookIndex = books.firstIndex(of: book) else { return }
         books.remove(at: bookIndex)
         saveToPersistentStore()
     }
    
    /// Updates when a book has been read in an array.
    /// - Parameter book: Book
     func updateHasBeenRead(for book: Book) {
         guard let bookIndex = books.firstIndex(of: book) else { return }

         if (book.hasBeenRead) {
             books[bookIndex].hasBeenRead = false
         } else {
             books[bookIndex].hasBeenRead = true
         }
         saveToPersistentStore()
     }
    
    /// Updates the title and reason to read a book in an array
    /// - Parameters:
    ///   - book: Book
    ///   - title: Title of Book
    ///   - reason: Reason to read
     func updateTitleAndReason(for book: Book, updateTitle title: String, updateReason reason: String) {
         guard let bookIndex = books.firstIndex(of: book) else { return }

         books[bookIndex].title = title
         books[bookIndex].reasonToRead = reason
         saveToPersistentStore()
     }
/// Mark: - Persistence
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let filename = "ReadingList.plist"
        return dir.appendingPathComponent(filename)
    }

    /// Saves changes to a book object in an array
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
    
    /// Loads the property list stored on the device
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


