//
//  BookController.swift
//  Reading List
//
//  Created by Juan M Mariscal on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        let readBook = books
        let booksFiltered = readBook.filter { $0.hasBeenRead == true }
        
        return booksFiltered
    }
    
    var unreadBooks: [Book] {
        let unreadBook = books
        let booksFiltered = unreadBook.filter { $0.hasBeenRead == false }
        
        return booksFiltered
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("books.plist")
    }
    
    @discardableResult func createBook(bookTitle title: String, reasonToRead reason: String) -> Book {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
        
        return book
    }
    
    func deleteBook(book:Book) {
        
        books = books.filter { $0 != book }
    }
    
    func updateHasBeenRead(for book: Book){
        if book.hasBeenRead == false{
            book.hasBeenRead = true
        } else {
            book.hasBeenRead = false
        }
    }
    
    func editBookProperties(newBook book: Book, newReason reason: Book) {
        
    }
    
    func saveToPersistentStore() {
        
        // Stars -> Data -> Plist
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Stars
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch {
            print("error loading stars data: \(error)")
        }
    }
}
