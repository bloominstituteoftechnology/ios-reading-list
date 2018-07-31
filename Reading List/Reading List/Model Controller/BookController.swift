//
//  BookController.swift
//  Reading List
//
//  Created by De MicheliStefano on 31.07.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    func saveToPersistentStore() {
        do {
            // Encoding entire books array to PropertyList and write it to "disk" at readingListURL
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            if let readingListURL = readingListURL {
                try booksData.write(to: readingListURL)
            }
        } catch {
            NSLog("An error occured while saving book: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            // Decode data at path readingListURL and update books array
            let decoder = PropertyListDecoder()
            guard let readingListURL = readingListURL else { return }
            let data = try Data(contentsOf: readingListURL)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            NSLog("An error occured while loading book: \(error)")
        }
    }
    
    private var readingListURL: URL? {
        // Grabing documents URL and appending filename ReadingList.plist
        let fm = FileManager()
        let fileName = "ReadingList.plist"
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentsDir.appendingPathComponent(fileName)
    }
    
    private(set) var books = [Book]()
    
}
