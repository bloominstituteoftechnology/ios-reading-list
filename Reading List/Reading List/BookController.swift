//
//  BookController.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    var books: [Book] = []
    
    // Access user's documents & create a plist
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return directory.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        // Books Array -> Data -> Write to plist file
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: readingListURL!)
        } catch {
            NSLog("Error saving book data: \(error)")
        }
    }
}
