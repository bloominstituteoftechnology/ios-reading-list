//
//  BookController.swift
//  Reading List
//
//  Created by Nichole Davidson on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    func createBook(with title: String, reasonToRead: String, hasBeenRead: Bool) {
        var book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        saveToPersistentStore()
    }
    func deleteBook(with title: String, reasonToRead: String, hasBeenRead: Bool) {
        let deletedBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: true)
//        books.filter { $0 != deletedBook }
        
        books.removeAll { $0 == deletedBook }
    }
    
    func updateHasBeenRead(for book: Book) {
        var hasBeenRead = false
        switch hasBeenRead{
        case true:
            hasBeenRead.toggle()
        default:
            hasBeenRead.toggle()
        }
        
        func updateBookInfo(with title: String, reasonToRead: String, hasBeenRead: Bool) {
//            let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
            
            
        }
        
    }
    
    
    // MARK: - Persistence
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
           
           let encoder = PropertyListEncoder()
           
           do {
           
               let booksData = try encoder.encode(books)
               
               guard let booksURL = readingListURL else { return }
               
              try booksData.write(to: booksURL)
               
           } catch {
               
               print("Unable to save books to plist: \(error)")
               
           }
       }
    
    func loadFromPersistentStore() {
        
        guard let booksURL = readingListURL else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            
            let bookListData = try Data(contentsOf: booksURL)
            
            let decodedBooks = try decoder.decode([Book].self, from: bookListData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error decoding books: \(error)")
            
        }
    }
}
