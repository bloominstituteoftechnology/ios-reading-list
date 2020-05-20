//
//  BookController.swift
//  Reading List
//
//  Created by Ian Becker on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    var readBooks: [Book] {
        books.filter {
            $0.hasBeenRead == true
        }
    }
    
    var unreadBooks: [Book] {
        books.filter {
            $0.hasBeenRead == false
        }
    }
    
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book : Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
        }
    
    func editBook(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books[index].title = "\(book.title)"
        books[index].reasonToRead = "\(book.reasonToRead)"
        saveToPersistentStore()
        
    }
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let readingListURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return readingListURL
    }
    func saveToPersistentStore() {
        
        do {
            
            guard let persistentFileURL = readingListURL else { return }
            
            let encoder = PropertyListEncoder()

            let booksData = try encoder.encode(books)
            
            try booksData.write(to: persistentFileURL)
            
            
        } catch {
            print("Error saving books: \(error)")
        }
    }
    func loadFromPersistentStore() {
        do {
            
            guard let persistentFileURL = readingListURL else { return }
            
            let booksData = try Data(contentsOf: persistentFileURL)
            
            let decoder = PropertyListDecoder()
            
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            
            self.books = decodedBooks
            
        } catch {
            print("Error loading books from plist: \(error)")
        }
    }
}
