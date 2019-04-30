//
//  PersistenceExtention.swift
//  Reading List
//
//  Created by Lisa Sampson on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

extension BookController {
    
    // MARK: - Properties
    var readingListURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "Reading List.plist"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    // MARK: - Persistence Methods
    func saveToPersistence() {
        let encoder = PropertyListEncoder()
        do {
            guard let readingList = readingListURL else { return }
            let booksArray = try encoder.encode(books)
            try booksArray.write(to: readingList)
            
        } catch let error {
            NSLog("Error trying to save data: \(error)")
        }
    }
    
    func loadFromPersistence() {
        do {
            guard let readingList = readingListURL else { return }
            let booksArray = try Data(contentsOf: readingList)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksArray)
            self.books = decodedBooks
            
        } catch let error {
            NSLog("Error trying to load data: \(error)")
        }
    }
    
}
