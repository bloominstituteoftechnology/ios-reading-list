//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_loaner_226 on 2/16/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    //MARK - Basic Persistence
    
    var readinglistURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readinglistURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadToPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readinglistURL,
            fileManager.fileExists(atPath: url.path) else {return}
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    //MARK - CRUD FUNCTIONS
    
    //MARK - CREATE
    @discardableResult func createBook(named title: String, reason reasonToRead: String, read hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    //MARK - Delete
    func deleteBook(book: Book) {
        books = books.filter { $0 != book }
        saveToPersistentStore()
    }
    
    //MARK - Update One
    func updateHasBeenRead(book: Book) {
        guard let index = books.firstIndex(of: book) else {return}
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    //MARK - Update Two
    func updateTitleOrReason(book: Book) {
       
        saveToPersistentStore()
    }
}
