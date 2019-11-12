//
//  BookController.swift
//  Reading List
//
//  Created by Alexander Supe on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter{ $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter{ $0.hasBeenRead == false }
    }
    
    init() {
        loadFromPersistantStore()
    }
    
    func createBook(title: String, reasonToRead: String) {
        books.append(Book(title: title, reasonToRead: reasonToRead))
        saveToPersistentStore()
    }
    
    func deleteBook(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func editBook(for book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return docDir.appendingPathComponent("ReadingList.plist")
        }
        
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            guard let fileURL = readingListURL else { return }
            try booksData.write(to: fileURL)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistantStore() {
        let fileManager = FileManager.default
        guard let fileURL = readingListURL,
            fileManager.fileExists(atPath: fileURL.path) else { return }
        do {
            let booksData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch  {
            print(error)
        }
    }
    
}
