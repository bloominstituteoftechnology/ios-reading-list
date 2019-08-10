//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_101 on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        return []
    }
    
    var unreadBooks: [Book] {
        return []
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
            let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    func addBook() {
        var newBook = Book(title: <#T##String#>, reasonToRead: <#T##String#>, hasBeenRead: <#T##Bool#>)
        books.append(newBook)
        
        saveToPersistentStore()
    }
    
    func deleteBook() {
    }
    
    func updateHasBeenRead( for book: Book) {
        
    }
}
