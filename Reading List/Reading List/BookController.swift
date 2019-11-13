//
//  BookController.swift
//  Reading List
//
//  Created by Ufuk Türközü on 12.11.19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookCotroller {
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        let read = books.filter(Book(hasBeenRead: true)
    }
    
    private var readingListURL: URL? {
         let fileManager = FileManager.default
               
               guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
               
               return documentsDir.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let booksData = try encoder.encode(books)
           
            guard let fileURL = readingListURL else { return }
            
            try booksData.write(to: fileURL)
            
        } catch /* optional: let starError (line 36 "...\(starError)" */ {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
      //  let fileManager = FileManager.default
        
        do {
            guard let fileURL = readingListURL
                    /* fileManager.fileExists(atPath: fileURL.path) */ else { return }
            
            let booksData = try Data(contentsOf: fileURL)
            
            let decoder = PropertyListDecoder()
            
            let  decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            books = decodedBooks
            
        } catch {
            print("Error loading books data: \(error)")
        }
        
    }

// Create

    func createBook(with title: String, reasonToRead: String, hasBeenRead: Bool?) -> Book {
        // This should initialize and return a star.

        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        
        saveToPersistentStore()
        
        return book
    }
    
    

}
