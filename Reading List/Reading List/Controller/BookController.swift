//
//  BookController.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    //
    // MARK: - Properties
    //
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    //
    // MARK: - Methods
    //
    
    func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("error saving books data: \(error)")
        }
    }
    
    func loadToPersistantStore() {
        do {
            guard let url = readingListURL else { return }
            let bookData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: bookData)
            books = decodeBooks
        } catch {
            print("error loading books data: \(error)")
        }
    }
    
}
