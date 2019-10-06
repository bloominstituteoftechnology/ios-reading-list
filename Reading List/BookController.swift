//
//  BookController.swift
//  Reading List
//
//  Created by Christy Hicks on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
  
    init() {
        loadFromPersistentStore()
    }
    
    // Set up an array to store books in.
    private var books: [Book] = []
    
    // Set up an array of all the books that have been read.
    var readBooks: [Book] {
       books.filter { $0.hasBeenRead == true }
    }
    
    // Set up an array of all the books that have not been read.
    var unreadBooks: [Book] {
        books.filter { $0.hasBeenRead == false}
    }
   
    // Create location for saving data
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
            return documents.appendingPathComponent("ReadingList.plist")
        }
    
    // Method for saving data
    func saveToPersistentStore() {

        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving book list: \(error)")
        }
    }
    
    // Method for loading data
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let booksData =  try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading book list: \(error)")
        }
    }
    
    // Method to add a book to the list
    func create(book: Book) {
        books.append(book)
        saveToPersistentStore()
    }
    
    // Method to remove a book from the list
    func delete(book: Book) {
        if books.contains(book) {
            guard let bookIndex = books.index(of: book) else { return }
            books.remove(at: bookIndex)
            saveToPersistentStore()
        }
    }
    // Method to update hasBeenRead
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.index(of: book) else { return }
        var updatedBook = book
        if book.hasBeenRead == true {
            updatedBook.hasBeenRead = false
        } else {
            updatedBook.hasBeenRead = true
        }
        books[bookIndex] = updatedBook
    }
    
    // Method to update title and/or reasonToRead properties
    func updateBookText(for book: Book, newTitle: String? = nil, newReason: String? = nil) {
        guard let bookIndex = books.index(of: book) else { return }
        var updatedBook = book
        if let newBookTitle = newTitle {
            updatedBook.title = newBookTitle
        }
        if let newBookReason = newReason {
            updatedBook.reasonToRead = newBookReason
        }
        books[bookIndex] = updatedBook
    }
    
    
}


