//
//  BookController.swift
//  Reading List
//
//  Created by Andrew Ruiz on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books : [Book] = []
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    
    var unreadBooks: [Book] {
        
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books to file: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks

        } catch {
            print("Error: Couldn't retrieve books from file: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        var bookReadStatus = books[index].hasBeenRead
        
        if bookReadStatus == true {
            bookReadStatus = false
        } else {
            bookReadStatus = true
        }
        saveToPersistentStore()
    }
    
    func updateBookProperties(for book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].reasonToRead = reasonToRead
        books[index].title = title
        saveToPersistentStore()
    }
}
