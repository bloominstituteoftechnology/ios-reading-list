//
//  BookController.swift
//  Reading List
//
//  Created by brian vilchez on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
class BookController  {
    
    //MARK: - Properties
   private(set) var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: - Methods
    func addBook(withTitle title:String, reasonToRead reason: String ) {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    
}

// created extension for persistance
extension BookController {
    
    var readingLIstURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectoy = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectoy.appendingPathComponent("readingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingLIstURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingLIstURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
    
}
