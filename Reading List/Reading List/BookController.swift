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
    
    init(){
        loadFromPersistentStore()
    }
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        savedToPresistentStore()
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

    var readBooks: [Book] {
            return books.filter({ $0.hasBeenRead })
        }
    var unreadBooks: [Book] {
            return books.filter({ $0.hasBeenRead == false })
        }
    
    var persistentFileURL: URL? {
    
    let fileManager = FileManager.default
    
    let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    
    let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
    
    return booksURL
}
        
    func savedToPresistentStore() {
        
        do {
            let encoder = PropertyListEncoder()
            
            let readingListPlist = try encoder.encode(books)
            
            guard let persistentFileURL = persistentFileURL else { return }
            
            try readingListPlist.write(to: persistentFileURL)
        
        } catch {
           
            print("Error saving books: \(error)")
            
        }
    }
    
        func loadFromPersistentStore() {
            
            guard let persistentFileURL = persistentFileURL else {return }
            
            do {
                
                let decoder = PropertyListDecoder()
                
                let readingListPlist = try Data(contentsOf: persistentFileURL)
            
                let decodedBooks = try decoder.decode([Book].self, from: readingListPlist)
                
                self.books = decodedBooks
                
                
            } catch {
                print("Error decoding books: \(error)")
            }
        }
    
}

