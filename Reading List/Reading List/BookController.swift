//
//  BookController.swift
//  Reading List
//
//  Created by Gladymir Philippe on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead})
        
    }
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false })
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func createBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(newBook)
        saveToPersistentStore()
    }
    func updateBook(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        var updatedBook = book
        updatedBook.title = title
        updatedBook.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(updatedBook, at: index)
        saveToPersistentStore()
    }
}




