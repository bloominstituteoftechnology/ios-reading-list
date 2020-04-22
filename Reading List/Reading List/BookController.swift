//
//  BookController.swift
//  Reading List
//
//  Created by Jason on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistenceStore()
    }
    
    var books: [Book] = []
    
    @discardableResult func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        
        return book
    }
    
}

var readingListURL: URL? {
    let fileManager = FileManager.default
    
    let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    
    let booksURL = documentsDir?.appendingPathComponent("books.plist")
    
    return booksURL
}

func saveToPersistentStore() {
    
    do {
        let encoder = PropertyListEncoder()
        
        let booksPlist = try encoder.encode(books)
        
        guard let readingListURL = readingListURL else { return }
        
        try booksPlist.write(to: readingListURL)
        
    } catch {
        print("Error saving books :\(error)")
    }
}

func loadFromPersistenceStore() {
    
    guard let readingListURL = readingListURL else { return }
    
    do {
        
        let decoder = PropertyListDecoder()
        
        let booksPlist = try Data(contentsOf: readingListURL)
        
        let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
        
        self.decodedBooks = books
        
    } catch {
        print("Error loading books from plist: \(error)")
    }
}

