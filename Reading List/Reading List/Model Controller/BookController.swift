//
//  BookController.swift
//  Reading List
//
//  Created by Ian French on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
  
    
    
    var readingListURL: URL? {
           let fm = FileManager.default
       
           guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
       
        
        let bookListURL = directory.appendingPathComponent("ReadingList.plist")
        return bookListURL
       }
        func saveToPersistentStore() {
           
             do {
               guard let url = readingListURL else { return }

               let encoder = PropertyListEncoder()
               let booksData = try encoder.encode(books)
               try booksData.write(to: url)
           } catch {
               NSLog("Error saving books data: \(error)")
           }
       }
       
       
             func loadFromPersistentStore() {
           
             do {
                let fm = FileManager.default
                guard let url = readingListURL,
                fm.fileExists(atPath: url.path) else { return }
           
         
               let data = try Data(contentsOf: url)
               let decoder = PropertyListDecoder()
               let decodedBooks = try decoder.decode([Book].self, from: data)
               books = decodedBooks
           } catch {
               NSLog("Error loading books data: \(error)")
           }
       }
    
    
    init() {
       loadFromPersistentStore()
    }
    
    

   
    func createBook(title: String, reasonToRead: String) {
           let book = Book(title: title, reasonToRead: reasonToRead)
           books.append(book)
        
           saveToPersistentStore()
          
       }
    
     func deleteBook(with book: Book) {
          guard let bookArrayIndex = books.firstIndex(of: book) else
          { return }
          books.remove(at: bookArrayIndex)
        
        
        saveToPersistentStore()
        
        
    }
    
    


    func updateBook(for book: Book, with title: String, and reasonToRead: String?) {
        if let index = books.firstIndex(of: book) {
           var book  = books[index]
            book.title = title
            if let reasonToRead = reasonToRead {
                book.reasonToRead = reasonToRead
                }
             
         saveToPersistentStore()
      
    }
    
}
    func updateHasBeenRead(for book: Book) {
            guard let status = books.firstIndex(of: book) else
            { return }
            books[status].hasBeenRead.toggle()
        
        
            saveToPersistentStore()
    
            
    }
    
    
    func editBookFields(for book: Book) {
        guard let editFields = books.firstIndex(of: book)
            else { return }
        books[editFields].title = book.title
        books[editFields].reasonToRead = book.reasonToRead
        
        
        saveToPersistentStore()
    }
    
    
    func editBook(book: Book, title: String) {
        guard let bookIndex = books.firstIndex(of: book)
            else { return }
        var placeholder = book
        placeholder.title = book.title
        books.remove(at: bookIndex)
        books.insert(placeholder, at: bookIndex)
        
        
        saveToPersistentStore()
    }
    
    
    
    
    
    
    
    
    var readBooks: [Book] {
        return books.filter {$0.hasBeenRead == true}
    }
    var unreadBooks: [Book] {
        return books.filter {$0.hasBeenRead == false}
    }
  
}
    

