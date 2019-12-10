//
//  BookController.swift
//  Reading List
//
//  Created by Osha Washington on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
   
    private (set) var books: [Book] = []
    
    private var persistentReadingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    // MARK: - SAVE
    func saveToPersistentStore() {
        guard let url = persistentReadingListURL else { return }
        
        do {
            let encoder =  PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
}
    
    // MARK: - LOAD
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = persistentReadingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let bookData = try Data(contentsOf: url)
            let decodeBooks = PropertyListDecoder()
            books = try decodeBooks.decode([Book].self, from: bookData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    //MARK: - CREATE
    func createBook(title: String, reasonToRead: String) {
        let createdBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(createdBook)
        saveToPersistentStore()
    }
    
    // MARK: - DELETE
    func deleteBook(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - UPDATE hasBeenRead
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    //MARK: - UPDATE updateBookTitle
    func updateBookTitle(for book: Book, newTitle: String, newReasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = newTitle
        books[index].reasonToRead = newReasonToRead
        saveToPersistentStore()
    }
    // MARK: - LIST OF READ BOOKS
  var readBooks: [Book] {
      var readBooks = books.filter { $0.hasBeenRead == true }
      readBooks = readBooks.sorted {
          $0.title < $1.title
      }
      return readBooks
  }
    // MARK: - LIST OF UNREAD BOOKS
    var unreadBooks: [Book] {
       var unreadBooks = books.filter { $0.hasBeenRead == false }
           unreadBooks = unreadBooks.sorted {
               $0.title < $1.title
       }
       return unreadBooks
   }
    
}
