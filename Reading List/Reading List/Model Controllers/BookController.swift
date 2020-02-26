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
        
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        
    }
    
    func deleteBook(for book: Book) {
        if let i =  books.firstIndex(of: book) {
            books.remove(at: i)
        }
        
        saveToPersistentStore()
        
        }
    
    func updateHasBeenRead(for book: Book) {
        var hasBeenRead = false
        switch hasBeenRead{
        case true:
            hasBeenRead.toggle()
        default:
            hasBeenRead.toggle()
        }
        saveToPersistentStore()
     }
    
        func updateBookInfo(with title: String, reasonToRead: String, hasBeenRead: Bool) {
            let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
            //CODE NEEDED: to edit book's title and/or reasonToRead properties
            saveToPersistentStore()
        }
        
        var readBooks: [Book] {
           return books.filter { $0 .hasBeenRead == true }
        }
    
        var unreadBooks: [Book] {
           return books.filter { $0 .hasBeenRead == false }
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
