//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_259 on 2/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: Properties
    private(set) var books: [Book] = []
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documents.appendingPathComponent("books.plist")
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        do {
            guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: data)
            books = decodeBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
