//
//  BookController.swift
//  Reading List
//
//  Created by Seschwan on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistenceStore()
        print(bookArray)
    }
    
    private(set) var bookArray: [Book] = []
    
    func addBookToList(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let newBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        bookArray.append(newBook)
        saveToPersistenceStore()
        print(bookArray)
    }
    
    // MARK: - Computed Variables
    var readBooks: [Book] {
        let readBooksList = bookArray.filter {$0.hasBeenRead == true}
        return readBooksList
    }
    
    var unreadBooks: [Book] {
        let unreadBooksList = bookArray.filter {$0.hasBeenRead == false}
        return unreadBooksList
    }
    
    // MARK: - Book Array Functions
    func deleteBookFromList(book: Book) {
        guard let index = bookArray.firstIndex(of: book) else {
            return
        }
        bookArray.remove(at: index)
        saveToPersistenceStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = bookArray.index(of: book) else { return }
        bookArray[index].hasBeenRead = !bookArray[index].hasBeenRead
        print(book.hasBeenRead)
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return documents.appendingPathComponent("readingList.plist")
    }
    
    
    
    // MARK: - Persistence Functions
    func saveToPersistenceStore() {
        guard let url = readingListURL else {
            return
        }
        do {
            let encoder = PropertyListEncoder()
            let bookData = try encoder.encode(bookArray)
            try bookData.write(to: url)
        } catch {
            NSLog("Error saving to disk: \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return
        }
        do {
            // Get the data
            let bookData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            bookArray = try decoder.decode([Book].self, from: bookData)
        } catch {
            NSLog("Error loading from disk: \(error)")
        }
    }
    
    
    
    
}
