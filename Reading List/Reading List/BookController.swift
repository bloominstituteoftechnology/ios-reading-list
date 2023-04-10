//
//  BookController.swift
//  Reading List
//
//  Created by Harm on 3/5/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    
    var books: [Book] = [Book(title: "ONE", reasonToRead: "sdfslauhdfajk"), Book(title: "BOOK TWO", reasonToRead: "reasonskgnjsodijsi")]
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let urlPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let updatedURLPath = urlPath?.appendingPathExtension("ReadingList.plist")
        
        return updatedURLPath
    }
    
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
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            
            guard let unwrappedReadingListURL = readingListURL else { fatalError("Unwrapping failed") }
            
            try booksData.write(to: unwrappedReadingListURL)
        } catch {
            fatalError("Error in saveToPersistentStore(): \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            
            guard let unwrappedReadingListURL = readingListURL else { fatalError("Unwrapping failed") }
            
            let data = try Data(contentsOf: unwrappedReadingListURL)
            
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: data)
            
            books = decodedBooks
            
        } catch {
            fatalError("Error in loadFromPersistentStore(): \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(newBook)
        
        saveToPersistentStore()
        
    }
    
    func deleteBook(book: Book) {
        if let indexOfBook = books.index(of: book) {
            
            books.remove(at: indexOfBook)
            
        } else {
            
            fatalError("No book exists to delete :/")
        }
        
        saveToPersistentStore()
        
    }
    
    func updateHasBeenRead(for book: Book) {
        
        if let indexOfBook = books.index(of: book) {
            
            if books[indexOfBook].hasBeenRead == true {
                
                books[indexOfBook].hasBeenRead = false
                
            } else {
                
                books[indexOfBook].hasBeenRead = true
                
            }
            
        } else {
            
            fatalError("No book exists to edit the hasBeenRead :/")
            
        }
        
        saveToPersistentStore()
        
    }
    
    func updateTitleOrReason(for book: Book, newTitle: String, newReason: String) {
        
        if let indexOfBook = books.index(of: book) {
            
            books[indexOfBook].title = newTitle
            books[indexOfBook].reasonToRead = newReason
            
        } else {
            
            fatalError("No book exists to edit Title or Reason")
            
        }
        
        saveToPersistentStore()
        
    }
    
}
