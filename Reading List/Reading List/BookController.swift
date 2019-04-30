//
//  BookController.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookController {
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead }
    }
    
    var unreadBooks: [Book] {
        return books.filter { !$0.hasBeenRead }
    }
    
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let document = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return document.appendingPathComponent("books.plist")
    }
    
    func addBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistenceStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
    }
    
    func updateBookHasBeenRead(for book: Book) {
        //update books has been read property
        guard let index = books.index(of: book) else {return}
        books[index].hasBeenRead.toggle()
        saveToPersistenceStore()
    }
    
    func updateBookDetails(for book: Book, reasonToRead: String, title: String) {
        //update book title and or reason to read properties
        guard let index = books.index(of: book) else {return}
        books[index].title = title
        books[index].reasonToRead = reasonToRead
    }
    
    
    func saveToPersistenceStore() {
        guard let url = readingListURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    
    func loadToPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {return}
        
        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: booksData)
        } catch {
            print(error)
        }
    }
}
