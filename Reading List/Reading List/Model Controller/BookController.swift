//
//  BookController.swift
//  Reading List
//
//  Created by Aaron Peterson on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class CookController {
    
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("books.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving dooks data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
}
