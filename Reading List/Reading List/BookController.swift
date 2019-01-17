//
//  BookController.swift
//  Reading List
//
//  Created by Moses Robinson on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookController {
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistantStore()
    }
    
    
    func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistantStore() {
        guard let url = readingListURL,
            FileManager.default.fileExists(atPath: url.path) else { return }
        
        let decoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print(error)
        }
    }
    
    //MARK: - Properties
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let finalURL = documentsDirectory.appendingPathComponent("books.plist")
        return finalURL
    }
    
    private(set) var books: [Book] = []
}
