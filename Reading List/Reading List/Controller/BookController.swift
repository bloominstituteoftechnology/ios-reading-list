//
//  BookController.swift
//  Reading List
//
//  Created by Shawn James on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    var books: [Book] = []
    var readBooks: [Book] { books.filter { $0.hasBeenRead } }
    var unreadBooks: [Book] { books.filter { $0.hasBeenRead == false }}
    
    // MARK: - Create
    func createBook(title: String, reasonToRead: String) {
        books.append(Book(title: title, reasonToRead: reasonToRead))
        saveToPersistentStore()
    }
    
    // MARK: - Delete
    func deleteBook(_ book: Book) {
        books.remove(at: books.firstIndex(of: book)!)
        saveToPersistentStore()
    }
    
    // MARK: - Update methods

    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    
    func updateText(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        books.insert(Book(title: title, reasonToRead: reasonToRead), at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persitence
    var readingListURL: URL? {
        let fileManager = FileManager.default
        // Grab the app's document directory
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        // Create location for plist
        let booksURL = documentDirectory?.appendingPathComponent("ReadingList.plist")
        // Return URL
        return booksURL
    }
    
    // MARK: - Save
    func saveToPersistentStore() {
        do {
            // encoder init
            let encoder = PropertyListEncoder()
            // what you want to save
            let booksPlist = try encoder.encode(books)
            // where do you want to save it?
            guard let readingListURL = readingListURL else { return }
            // save what you want to save to where you want to save it
            try booksPlist.write(to: readingListURL)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    // MARK: - Load
    func loadFromPersistentStore() {
        guard let readingListURL = readingListURL else { return }
        do {
            // create decoder
            let decoder = PropertyListDecoder()
            // grab data in plist from persistentFileURL
            let booksPlist = try Data(contentsOf: readingListURL)
            // plist -> [Star]
            let books = try decoder.decode([Book].self, from: booksPlist)
            // replace star array with saved array
            self.books = books
        } catch {
            print("Error loading stars: \(error)")
        }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
}
