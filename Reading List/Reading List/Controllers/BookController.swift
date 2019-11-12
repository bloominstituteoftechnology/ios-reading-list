//
//  BookController.swift
//  Reading List
//
//  Created by Donella Barcelo on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    
    // MARK: - Reading List URL
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDir.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        var readBooks = books.filter { $0.hasBeenRead == true }
        readBooks = readBooks.sorted {
            $0.title < $1.title
        }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        var unreadBooks = books.filter { $0.hasBeenRead == false }
            unreadBooks = unreadBooks.sorted {
                $0.title < $1.title
        }
        return unreadBooks
    }
    
    func saveToPersistentStore() {
        guard let fileURL = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: fileURL)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let fileURL = readingListURL,
            fileManager.fileExists(atPath: fileURL.path) else { return }
        let decoder = PropertyListDecoder()
        do {
            let booksData = try Data(contentsOf: fileURL)
            books = try decoder.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let createdBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(createdBook)
        saveToPersistentStore()
    }
    
    func deleteBook(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateBookInfo(for book: Book, newTitle: String, newReasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = newTitle
        books[index].reasonToRead = newReasonToRead
        saveToPersistentStore()
    }
}
