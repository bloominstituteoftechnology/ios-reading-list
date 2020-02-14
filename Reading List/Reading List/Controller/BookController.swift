//
//  BookController.swift
//  Reading List
//
//  Created by Breena Greek on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        
        // Books -> Data -> Plis
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Books
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return }
        
        
        do {
            let decoder = PropertyListDecoder()
            let booksData = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: booksData)
            
        } catch {
            print("error loading stars data: \(error)")
            
        }
    }
  
}
