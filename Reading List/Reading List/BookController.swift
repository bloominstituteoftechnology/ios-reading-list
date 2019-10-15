//
//  BookController.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books = [Book]()
    
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
}
