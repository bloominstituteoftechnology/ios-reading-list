//
//  BookController.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // MARK: - PROPERTIES
    var books: [Book] = []
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let listURL = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return listURL
    }
    var readBooks: [Book] {
        let read = books.filter { return $0.hasBeenRead }
        return read
    }
    var unreadBooks: [Book] {
        let unread = books.filter { return !$0.hasBeenRead }
        return unread
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - SAVE BOOKS
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let bookData = try encoder.encode(books)
            guard let listURL = readingListURL else { return }
            try bookData.write(to: listURL)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    // MARK: - LOAD BOOKS
    func loadFromPersistentStore() {
        do {
            if let listURL = readingListURL {
                let bookData = try Data(contentsOf: listURL)
                let decoder = PropertyListDecoder()
                let decodedBooks = try decoder.decode([Book].self, from: bookData)
                books = decodedBooks
            }
        } catch {
            print("Error decoding item array: \(error.localizedDescription)")
        }
    }
    
    // MARK: - CREATE / ADD BOOKS
    func create(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    // MARK: - DELETE BOOKS
    func delete(book: Book) {
        if let bookIndex = books.firstIndex(of: book) {
            books.remove(at: bookIndex)
            saveToPersistentStore()
        }
    }
    
    // MARK: - UPDATE / EDIT BOOKS
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    }
    
    func updateText(for book: Book, title: String?, reasonToRead: String?) {
        if let index = books.firstIndex(of: book) {
            if let titleUnwrap = title {
                books[index].title = titleUnwrap
            }
            if let reasonUnwrap = reasonToRead {
                books[index].reasonToRead = reasonUnwrap
            }
            saveToPersistentStore()
        }
    }
    
    
    
}
