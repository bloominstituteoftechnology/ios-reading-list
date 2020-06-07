//
//  BookController.swift
//  Reading List
//
//  Created by Cora Jacobson on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    func createBook(_ title: String, _ reasonToRead: String) {
        let book = Book(title, reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(_ book: Book) {
        if let bookIndex = books.firstIndex(of: book) {
            books.remove(at: bookIndex)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(_ book: Book) {
        if let bookIndex = books.firstIndex(of: book) {
            switch books[bookIndex].hasBeenRead {
            case true:
                books[bookIndex].hasBeenRead = false
            case false:
                books[bookIndex].hasBeenRead = true
            }
        }
        saveToPersistentStore()
    }
    
    func editBook(_ book: Book, _ newTitle: String?, _ newReason: String?) {
        if let bookIndex = books.firstIndex(of: book) {
            if let editTitle = newTitle,
                !editTitle.isEmpty {
                books[bookIndex].title = editTitle
            }
            if let editReason = newReason,
                !editReason.isEmpty {
                books[bookIndex].reasonToRead = editReason
            }
        }
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        let readBooksArray = books.filter { $0.hasBeenRead == true }
        return readBooksArray.sorted(by: { $0.title < $1.title })
    }
    
    var unreadBooks: [Book] {
        let unreadBooksArray = books.filter { $0.hasBeenRead == false }
        return unreadBooksArray.sorted(by: { $0.title < $1.title })
    }
    
    // MARK: Persistence
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        let filename = "ReadingList.plist"
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent(filename)
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            NSLog("Was not able to encode data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL,
            fm.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("No data was saved: \(error)")
        }
    }
    
}
