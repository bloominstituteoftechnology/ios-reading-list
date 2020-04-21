//
//  BookController.swift
//  Reading List
//
//  Created by Nonye on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    //MARK: 6. CRUD
    
    @discardableResult func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPresistenceStore()
        return book
    }
//MARK: #3
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documentsDir.appendingPathComponent("ReadingList.plist")
//MARK: #7 Adding Filter
        var readBooks: [Book] {
            return books.filter { book in book.hasBeenRead }
        }
        var unreadBooks: [Book] {
            return books.filter { book in !book.hasBeenRead }
        }
    }
    
//MARK: #4
    func saveToPresistenceStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving book data: \(error)")
    }
}
//MARK: #5
        func loadFromPersistentStore() {
             do {
            guard let url = readingListURL else { return }
           
                let booksData = try Data(contentsOf: url)
                let booksPlist = PropertyListDecoder()
                let decodeBooks = try booksPlist.decode([Book].self, from: booksData)
            } catch {
                print("Error loading data from books \(error)")
            }
        }
    }
    
