//
//  BookController.swift
//  Reading List
//
//  Created by Marissa Gonzales on 4/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        
        var readBooksArray: [Book] = []
        
        for book in books {
            
            if book.hasBeenRead == true {
                
                readBooksArray.append(book)
            }
        }
        return readBooksArray
    }
    var unreadBooks: [Book] {
        
        var unreadBooksArray: [Book] = []
        
        for book in books {
            
            if book.hasBeenRead == false {
                
                unreadBooksArray.append(book)
            }
        }
        return unreadBooksArray
    } 
    
    // Initializing load
    
    init() {
        
        loadToPersistenceStore()
    }
    
    
    
    // Create book
    
    @discardableResult func createABook(title: String, reasonsToRead: String) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonsToRead)
        
        books.append(book)
        
        saveToPersistenceStore()
        
        return book
    }
    
    // Delete
    
    func deleteBook(book: Book) {
        
        for _ in books {
            
            books.remove(at: 0)
        }
    }
    
    // updateHasBeenRead
    
    func updateHasBeenRead(for book: Book) {
        
        if book.hasBeenRead == true {
            
            return
        }
        
        if book.hasBeenRead == false {
            
            return
        }
    }
    
    // updateBook(title/reasonToRead)
    
    func updateBook() {
        
    }
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        // Grab the apps document directory
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        // Create filename for plist
        
        let readingPList = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return readingPList
    }
    
    func saveToPersistenceStore() {
        do {
            
            let encoder = PropertyListEncoder()
            
            let readingPlist = try encoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            
            try readingPlist.write(to: readingListURL)
            
        }
            
        catch let saveError {
            print("Error Saving Books: \(saveError)")
        }
        
    }
    
    func loadToPersistenceStore() {
        
        guard let readingListURL = readingListURL else { return }
        
        do {
            
            let decoder = PropertyListDecoder()
            
            let booksURL = try Data(contentsOf: readingListURL)
            
            let books = try decoder.decode([Book].self, from: booksURL)
            
            self.books = books
        } catch {
            print("Error decoding stars: \(error)")
        }
    }
}

