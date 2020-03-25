//
//  BookController.swift
//  Reading List
//
//  Created by Chris Dobek on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    var readBooks: [Book] {books.filter({ $0.hasBeenRead })}
    var unreadBooks: [Book] {books.filter({ $0.hasBeenRead == false })}
    
    var persistentFileURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    func createBook(withBook title: String, reasonToRead: String) {
        books.append(Book(title: title, reasonToRead: reasonToRead))
        savedToPresistentStore()
    }
    
    func savedToPresistentStore() {
           
           do {
               let encoder = PropertyListEncoder()
               
               let booksPlist = try encoder.encode(books)
               
               guard let persistentFileURL = persistentFileURL else { return }
               
               try booksPlist.write(to: persistentFileURL)
           
           } catch {
              
               print("Error saving books: \(error)")
               
           }
       }
    
    func loadFromPersistentStore() {
               
               guard let persistentFileURL = persistentFileURL else {return }
               
               do {
                   
                   let decoder = PropertyListDecoder()
                   
                   let booksPlist = try Data(contentsOf: persistentFileURL)
               
                   let books = try decoder.decode([Book].self, from: booksPlist)
                   
                   self.books = books
                   
               } catch {
                   print("Error decoding books: \(error)")
               }
    }
       
    
    init(){
        loadFromPersistentStore()
    }
       
        
        func deleteBook(book: Book) {
            guard let bookIndex = books.firstIndex(of: book) else { return }
            books.remove(at: bookIndex)
            savedToPresistentStore()
            
    }
        
      func updateHasBeenRead(for book: Book) {
          guard let bookIndex = books.firstIndex(of: book) else { return }
          if books[bookIndex].hasBeenRead == true {
              books[bookIndex].hasBeenRead = false
          } else if books[bookIndex].hasBeenRead == false {
                  books[bookIndex].hasBeenRead = true
          }
      }
        
        func updateBook(for book: Book, title: String, reasonToRead: String){
            guard let index = books.firstIndex(of: book) else {return}
            books[index].title = title
            books[index].reasonToRead = reasonToRead
        }
}

