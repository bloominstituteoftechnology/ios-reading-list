//
//  BookController.swift
//  Reading List again
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books = [Book]()
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = directory.appendingPathComponent("realingList.plist")
        
        return url
    }
    
    var readBooks: [Book] {
        let readBooks = books.filter({ $0.hasBeenRead == true })
        return readBooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter({ $0.hasBeenRead == false })
        return unreadBooks
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        guard let url = readingListURL,
            FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch {
            print(error)
        }
    }
    
    func createBook(with title:String, reasonToRead: String) {
        let newBook = Book(with: title, reasonToRead: reasonToRead)
        books.append(newBook)
        
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
    }
    
    func update(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
    }
    
}
