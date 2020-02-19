//
//  BookController.swift
//  Reading List
//
//  Created by Bree Jeune on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    
    // CRUD
    
    @discardableResult func createBook(titled title: String, ofReason reasonToRead: String, beenRead hasBeenRead: Bool) -> Book {
           let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
           books.append(book)
           saveToPersistentStore()
           return book
       }
    
    //Reference Function
       
//       func listStars() -> String {
//           var output = ""
//           for book in books {
//               output += "\(book.title) is \(book.reasonToRead) has \(book.hasBeenRead)."
//           }
//           return output
//       }
//
    
    
    // Save to PList
    
    func saveToPersistentStore() {
               
               guard let url = readingListURL else { return }
           do {
               let encoder = PropertyListEncoder()
               let booksData = try encoder.encode(books)
               try booksData.write(to: url)
           } catch {
               print("Error saving book data: \(error)")
           
           }
    }
    
    // Load from PList
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
                return }
            
        do {
            let booksData = try Data(contentsOf: url)
            let decodeBooks = PropertyListDecoder()
            books = try decodeBooks.decode([Book].self, from: booksData)
            } catch {
                print("Error saving book data: \(error)")
            }
        }
    
}

