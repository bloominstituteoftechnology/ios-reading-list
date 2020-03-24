//
//  BookController.swift
//  Reading List
//
//  Created by Cameron Collins on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

/**
 Keeps track of the users book data and uses persistence. Only 1 object of BookController should be created.
 */
class BookController {
    
    //CRUD
    
    //Variables
    private var books: [Book] = []
    
    //Computed Properties
    var readBooks: [Book] {
        var myReadBooks: [Book] = []
        
        for i in books {
            if i.hasBeenRead == true {
                myReadBooks.append(i)
            }
        }
        
       return myReadBooks
    }
    
    var unreadBooks: [Book] {
        var myUnreadBooks: [Book] = []
         
         for i in books {
             if i.hasBeenRead == false {
                 myUnreadBooks.append(i)
             }
         }
         
        return myUnreadBooks
    }
    
    
    
    //Create
    func createBook(hasBeenRead: Bool, title: String, reasonToRead: String) {
        books.append(Book(hasBeenRead: hasBeenRead, title: title, reasonToRead: reasonToRead))
        saveToPersistentStore()
    }
    
    //Read
    func getBooks() -> [Book] {
        return books
    }
    
    //Update
    func updateHasBeenRead(for book: Book) {
        for i in 0...books.count - 1 {
            if books[i] == book {
                books[i].hasBeenRead = book.hasBeenRead
            }
        }
    }
    
    func updateBook(for book: Book) {
        for i in 0...books.count - 1 {
            if books[i] == book {
                books[i].title = book.title
                books[i].reasonToRead = book.reasonToRead
            }
        }
    }
    
    
    //Delete
    func deleteBook(book: Book) {
        for i in 0...books.count - 1 {
            if books[i] == book {
                books.remove(at: i)
            }
        }
    }
    
    //Initializer
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: -Persistence
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .allDomainsMask).first
        let bookURL = directory?.appendingPathComponent("ReadingList.plist")

        return bookURL
    }
    
    //Update/Save
    func saveToPersistentStore() {
       
        do {
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            //Unwrapping URL
            guard let readingURL = readingListURL else {
                return
            }
            
            try booksData.write(to: readingURL)
            
        } catch {
            print("Error BookController Could not save file: \(error)")
        }
    }
    
    //Load
    func loadFromPersistentStore() {
        
        do {
            //Unwrapping URL
            guard let readingURL = readingListURL else {
                return
            }
            
            //Access Contents
            let readingData = try Data(contentsOf: readingURL)
            
            //Decode contents and assign them
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: readingData)
            books = decodedBooks
        } catch {
            print("Error BookController Could not load file: \(error)")
        }
    }
    
    

}
