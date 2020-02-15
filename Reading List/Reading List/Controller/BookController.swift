//
//  BookController.swift
//  Reading List
//
//  Created by Breena Greek on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true}
    }
    var unreadBooks: [Book] {
        return books.filter {$0.hasBeenRead == false}
    }
    
    //CRUD
    @discardableResult func createBook(titled title: String,_ reasonToRead: String, _ hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
            books.append(book)
            saveToPersistentStore()
            return book
        }
    func deleteBook(_ book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func updateeHadBeenRead(for book: Book) {
    }
    
    func saveToPersistentStore() {
        
        // Books -> Data -> Plis
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Books
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {
            return }
        
        
        do {
            let decoder = PropertyListDecoder()
            let booksData = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: booksData)
            
        } catch {
            print("error loading stars data: \(error)")
            
        }
    }
}
