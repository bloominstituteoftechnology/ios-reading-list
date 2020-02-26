//
//  BookController.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    var readingListURL: URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let listURL = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return listURL
    }
    
    init() {
        // FIXME: - what goes here?
    }
    
    // MARK: - SAVE
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let bookData = try encoder.encode(books)
            guard let listURL = readingListURL else { return }
            try bookData.write(to: listURL)
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    // MARK: - LOAD
    func loadFromPersistentStore() {
        do {
            if let listURL = readingListURL {
                let bookData = try Data(contentsOf: listURL)
                let decoder = PropertyListDecoder()
                let decodedBooks = try decoder.decode([Book].self, from: bookData)
                books = decodedBooks
            }
        } catch {
            print("Error decoding item array: \(error.localizedDescription)")
        }
    }
    
}
