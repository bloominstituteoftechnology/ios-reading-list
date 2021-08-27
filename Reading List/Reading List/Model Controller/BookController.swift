//
//  BookController.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 8/27/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDir.appendingPathComponent("ReadingList.plist")
        
    }
    
     var readBooks: [Book] {
       return books.filter { $0.hasBeenRead == true }
    }
    
    var unReadBooks: [Book] {
        return books.filter { $0.hasBeenRead != true }
    }
    
    // MARK: - CRUD
    @discardableResult func createBook(titled title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistantStore()
        return book
    }
    
    func deleteBook(book: Book) {
        if books.contains(book) {
           books = books.filter { $0 != book }
        }
    }
    
    func updateHasBeenRead(for book: inout Book) {
        if book.hasBeenRead == false {
            book.hasBeenRead = true
        } else if book.hasBeenRead == true {
            book.hasBeenRead = false
        }
    }
    
    func updateBook(for book: inout Book, title: String, reasonToRead: String) -> Book {
        if book == book {
            book.title = title
            book.reasonToRead = reasonToRead
        }
        return book
    }
    
    // MARK: - Persistence
    private func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
    
    private func loadFromPersistenStore() {
        let fileManger = FileManager.default
        guard let url = readingListURL,
               fileManger.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
