//
//  BookController.swift
//  Reading List
//
//  Created by B$hady on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    
    func create(with title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        
        saveToPersistentStore()
        
        return book
        
    }
    
    func delete() {
        
        
        
        
    }
    
    
    var readingListURL: URL? {
    let fileManagager = FileManager.default
        
    guard let documentsDir = fileManagager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
    let readingListURL = documentsDir.appendingPathComponent("readingList.plist")
        
        return readingListURL
    }
    
    func saveToPersistentStore() {
        
        guard let fileURL = readingListURL else { return }
        
        do {
            
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: readingListURL!)
        
        } catch {
            print("Error encoding books array")
            
        }
    }
    
    
    func loadFromPersistentStore() {
        
        guard let fileURL = readingListURL else { return }
        
        do {
            
        let booksData = try Data(contentsOf: fileURL)
        
        let decoder = PropertyListDecoder()
            
            let booksArray = try decoder.decode([Book].self, from: booksData)
            
        } catch {
            print(
            "Error decoding books: \(error)")
            
        }
        
        
        
    }
    
    
    
    
}
