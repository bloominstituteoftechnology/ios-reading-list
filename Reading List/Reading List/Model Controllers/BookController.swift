//
//  BookController.swift
//  Reading List
//
//  Created by Mike Nichols on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//
import Foundation

// #1
class BookController {
    
    // #2
    var books: [Book] = []
    
    // #3
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let url = documentsDir?.appendingPathComponent("books.plist")
        
        return url
    }
    
    // #6
    func createBook(_ title: String, _ reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(_ book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            
        }
    }
    
    func updateHasBeenRead(for book: Book) {
    if book.hasBeenRead == true {
        readBooks.append(book)
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        } else {
        }
        
    
    // #4
    func saveToPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving books: \(error)")
            
        }
        
    }
    
    // #5
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            
            let booksData = try Data(contentsOf: readingListURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error loading books from plist: \(error)")
            
        }
    }
}
}
