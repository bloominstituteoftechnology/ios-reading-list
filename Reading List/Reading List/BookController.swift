//
//  BookController.swift
//  Reading List
//
//  Created by David Williams on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    //    init() {
    //        loadFromPersistentStore()
    //    }
    
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    @discardableResult func createStar(named name: String, hasRead:  Bool) -> Book {
        let book = Book(title: name, hasBeenRead: hasRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Data in Plist -> Book
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        do {
            let booksData =  try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books =  try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    #warning("How to implement?")
    func deleteBook(book: Book) {
        books.remove(at: <#T##Int#>)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        Book.shared.hasBeenRead = !Book.shared.hasBeenRead
    }
    
}
