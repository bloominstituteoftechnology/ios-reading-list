//
//  BookController.swift
//  Reading List
//
//  Created by Jordan Davis on 5/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class bookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    func addBook(titled title: String, withReason reasonToRead: String, with hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: title)
        
        books.append(book)
        
        saveToPersistentStore()
    }
    
    //save data
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    
    //load data
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    
    
    
    
    //MARK: -Properties
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    private(set) var books: [Book] = []
}
