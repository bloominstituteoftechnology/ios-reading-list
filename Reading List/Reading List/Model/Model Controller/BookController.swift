//
//  BookController.swift
//  Reading List
//
//  Created by Malik Barnes on 1/29/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
            
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            
        let readlingListURL = documentsDir.appendingPathComponent("readingList.plist")
            
        return readlingListURL
    }
    
    
    func saveToPersistentStore() {
           
           guard let fileURL = persistentFileURL else { return }
           
           do {
               
               let encoder = PropertyListEncoder()
               
               let booksData = try encoder.encode(books)
               
               try booksData.write(to: fileURL)
                } catch {
               print("Error saving books: \(error)")
           }
       }
    
    func loadFromPersistentStore() {
         
           guard let fileURL = persistentFileURL else { return }
           
           
           do {
           
           let booksData = try Data(contentsOf: fileURL)
           
           let decoder = PropertyListDecoder()
               
           let booksArray = try decoder.decode([Book].self, from: booksData)
               
               self.books = booksArray
               
           } catch {
               print("Error loading books from plist \(error)")
           }
    }
    
    @discardableResult func createBook(with title: String, reasonToRead: String, hasBeenRead: Bool = false) -> Book {
           // At the LEAST, initialize a star and return it.
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
           
           books.append(books)
           saveToPersistentStore()
           
           return books
       }
}
