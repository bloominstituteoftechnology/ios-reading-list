//
//  BookController.swift
//  Reading List
//
//  Created by Sameera Roussi on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    // Save and load book data from persistent store
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else {
                return nil
        }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        
        // Set up the URL for the save and make sure we are able to access it
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving book list: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        // Point to the FileManager and make sure the file is there
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            print("Load failed to find file")
            return
        }
        
        //Load then decode the data
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    
    
}
