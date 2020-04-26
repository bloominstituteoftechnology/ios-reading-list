//
//  BookController.swift
//  Reading List
//
//  Created by Clayton Watkins on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // Our array of book objects
    var books: [Book] = []
    
    // Filters all read books
    var readBooks: [Book]{
        let myBooks = books
        let filteredReadBooks = myBooks.filter { (myBooks) -> Bool in myBooks.hasBeenRead == true}
        return filteredReadBooks
    }
    
    // Filters all unread books
    var unreadBooks: [Book]{
        let myBooks = books
        let filteredUreadBooks = myBooks.filter { (myBooks) -> Bool in myBooks.hasBeenRead == false}
        return filteredUreadBooks
    }
    
    // Creating Persistence and stating files will be saved in user's documents
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask) .first else { return nil }
        return directory.appendingPathComponent("books.plist")
    }
    // This will allow user to be able to save book objects
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch{
            NSLog("Error saving books data: \(error)")
        }
    }
    // This will allow user to be able to load the book objects they have saved
    func loadFromPersistentStore() {
        do{
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            self.books = decodedBooks
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    }
    // This allows us to create a New Book
    func createBook(name: String, reasonToRead: String) {
        let newBook = Book(title: name, reasonToRead: reasonToRead)
        self.books.append(newBook)
        saveToPersistentStore()
    }
    // This will allow us to remove a specific book
    func removeBook(book: Book){
        guard let bookIndex = books.index(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }
    // This will allow us to be able to update wether or not a book has been read
    func updateHasBeenRead(for book: Book){
        if let bookIndex = books.index(of: book) {
            books[bookIndex].hasBeenRead.toggle()
        }
        saveToPersistentStore()
    }
    // This will allow us to change a specific book's title and reason to be read
    func updateBook(for book: Book, title: String, reasonToRead: String){
        if let bookIndex = books.index(of: book) {
            books[bookIndex].title = title
            books[bookIndex].reasonToRead = reasonToRead
        }
        saveToPersistentStore()
    }
}
