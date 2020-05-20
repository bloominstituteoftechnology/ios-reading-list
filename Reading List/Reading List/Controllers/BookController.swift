//
//  BookController.swift
//  Reading List
//
//  Created by Rebecca Overare on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
// Source of truth(holds all of our book objects) for the app holds all the info

// Everything is being communicated between views and models with the controller
class BookController {
    // CRUD
    var books: [Book] = []
    //Create a book
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let readingListURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        return readingListURL
    }
    func saveToPersistentStore(){
        do {
            guard let persistentFileURL = readingListURL else { return }
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to:persistentFileURL)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    func loadFromPersistentStore() {
        do {
            guard let persistentFuleURL = readingListURL else { return }
            let booksData = try Data(contentsOf: persistentFuleURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch {
            print("Error loading books: \(error)")
        }
    }
   func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        
    }
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at:index)
        saveToPersistentStore()
    }
    func updateHasBeenRead(for book: Book) {
       
    }
    func editBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        
        
    }
}
    
    
    
