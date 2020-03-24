//
//  BookController.swift
//  Reading List
//
//  Created by Harmony Radley on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
        
    }
    
    func saveToPersistentStore() {
        
        do {
            
            let encoder = PropertyListEncoder()
            
            let readingListPlist = try encoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            
            try readingListPlist.write(to: readingListURL)
        } catch {
            print("Error saving books: \(error).")
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let readingListURL = readingListURL else { return }
        
        do {
            
            let decoder = PropertyListDecoder()
            
            let readingListPlist = try Data(contentsOf: readingListURL)
            
            let books = try decoder.decode([Book].self, from: readingListPlist)
            
            self.books = books
            
        } catch {
            
        }
    }
}
