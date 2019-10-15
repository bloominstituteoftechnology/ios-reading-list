//
//  BookController.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books = [Book]()

    var readBooks: [Book] { return books.filter { $0.haveRead }}
    var unreadBooks: [Book] { return books.filter { !$0.haveRead }}
    
    func createBook(called title: String, for reason: String, haveRead: Bool) {
        let newBook = Book(title: title, reasonToRead: reason, haveRead: haveRead)
        
        if !books.contains(newBook) {
            books.append(newBook)
            saveToPersistenceStore()
        } else {
            print(BooksError.bookAlreadyInList)
        }
    }
    
    func deleteBook(_ bookToRemove: Book) {
        guard let indexToRemove = books.firstIndex(of: bookToRemove) else {
            print(BooksError.bookNotInList)
            return
        }
        books.remove(at: indexToRemove)
        saveToPersistenceStore()
    }
    
    // can do this in one method with overloading; if it's good enough for Apple, it's good enough for me!
    func update(book: Book, titleTo title: String?, hasBeenRead: Bool?) {
        guard let bookIndex = books.firstIndex(of: book) else {
            print(BooksError.bookNotInList)
            return
        }
        
        if let hasBeenRead = hasBeenRead {
            books[bookIndex].haveRead = hasBeenRead
        }
        if let title = title {
            books[bookIndex].title = title
        }
    }
    
    // MARK: Persistence
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
    
    private func saveToPersistenceStore() {
        guard let readingListURL = readingListURL else {
            print(BooksError.troubleGettingReadingList)
            return
        }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: readingListURL)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    private func loadFromPersistenceStore() {
        let fm = FileManager.default
        guard let url = readingListURL else {
            print(BooksError.troubleGettingReadingList)
            return
        }
        if !fm.fileExists(atPath: url.path) {
            print(BooksError.readingListFileDoesNotExist)
        }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}

enum BooksError: Error {
    case troubleGettingReadingList
    case readingListFileDoesNotExist
    case bookNotInList
    case bookAlreadyInList
    case noBookInTableCell
}
