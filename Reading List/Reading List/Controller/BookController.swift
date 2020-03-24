//
//  BookController.swift
//  Reading List
//
//  Created by Mark Poggi on 3/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(name: String, reasonToRead: String, hasBeenRead: Bool) {
        
        let book = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)  // store the book in an array above.
        saveToPersistentStore() // save our book to the file.
        
    }
    
    func deleteBook(name: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        if books.contains(book) {
            let index = books.firstIndex(of: book)
            books.remove(at: index!)
        }
    }
    
   
    
//    func updateHasBeenRead(for book: Book) {
//        let index2 = books.firstIndex(of: book)
//        book.hasBeenRead == true {
//            
//        }
//        
//
//
//}

    var unreadBooks: [Book] {
        for book in books {
            if book.hasBeenRead == true {
                print(book)
            }
        }
    }

    
    
    
    
    //MARK: - Persistence

// Where are we goint to save and load our books from?  We create a computed property rather than hard coding as iOS moves files around.  This means we never have a broken link/URL.

var readingListURL: URL? {
    
    let fileManger = FileManager.default
    
    // Grab the app's documents directory - ex. MyUser/Documents/
    let documentsDir = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
    
    // Create a unique locatino for the books property lsit (plist)
    let booksURL = documentsDir?.appendingPathComponent("books.plist")
    
    return booksURL
}

func saveToPersistentStore() {
    
    do {
        
        // Create the encoder
        let encoder = PropertyListEncoder()
        
        // Encode the books into a plist
        let booksData = try encoder.encode(books)
        
        // Grab the location we want to save the plist to.
        guard let persistentFileURL = readingListURL else { return }
        
        // Save the file to the documents directory
        try booksData.write(to: persistentFileURL)
        
    } catch {
        // Handle the error that gets "thrown" here.  iOS interpolates the error for you here.
        // This catch statement will only run if a throwing method fails.
        print("Error saving books: \(error)")
    }
    
}

func loadFromPersistentStore() {
    
    guard let persistentFileURL = readingListURL else { return }
    
    do {
        
        // Creatge the decoder
        let decoder = PropertyListDecoder()
        
        // Grab the data (plist)
        let booksData = try Data(contentsOf: persistentFileURL)
        
        // Plist -> [Book]
        let books = try decoder.decode([Book].self, from: booksData)
        
        self.books = books
        
    } catch {
        print("Error decoding books: \(error)")
    }
}
}

