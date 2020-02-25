//
//  BookController.swift
//  Reading List
//
//  Created by Wyatt Harrell on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    var books: [Book] = []
    
    
    var readBooks: [Book] {
        return books.filter{$0.hasBeenRead == true}
    }
    
    var unReadBooks: [Book] {
        return books.filter{$0.hasBeenRead == false}
    }
    
    // CRUD
    
    func create(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        
        saveToPersistentStore()
        
    }
    
    func delete(book: Book) {
        var index = 0
        for aBook in books {
            if aBook.title == book.title {
                books.remove(at: index)
            }
            index += 1
        }
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        for i in 0..<books.count {
            if books[i].title == book.title {
                if books[i].hasBeenRead {
                    books[i].hasBeenRead = false
                } else {
                    books[i].hasBeenRead = true
                }
            }
        }
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book) {
        //
        saveToPersistentStore()
    }
    
    
    // MARK: - Persistence
    
    var readingListURL: URL? {
        let fileManager = FileManager()
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let bookPList = "ReadingList.plist"
        
        return documentsDir?.appendingPathComponent(bookPList)
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)

            guard let booksURL = readingListURL else { return }
            
            try booksData.write(to: booksURL)

        } catch {
            print("Unable to save books to plist \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        
        guard let booksURL = readingListURL else { return }
        let decoder = PropertyListDecoder()
        
        do {
            
            let booksData = try Data(contentsOf: booksURL)
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error decoding books: \(error)")
        }
        
    }
    
}
