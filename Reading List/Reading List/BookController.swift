//
//  BookController.swift
//  Reading List
//
//  Created by Joshua Rutkowski on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books = [Book]()
    
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }
    
    // MARK: - Persistence
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
