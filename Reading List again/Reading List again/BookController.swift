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
        loadFromPersistence()
    }
    
    private(set) var books: [Book] = []
    
    func createBook(title: String, reason: String) {
        let newBook = Book(title: title, reasonToRead: reason)
        books.append(newBook)
        saveToPersistence()
    }
    
    func updateTitleReason(for book: Book, title: String, reason: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reason
        saveToPersistence()
    }
    
    func updateIsRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].isRead = !books[index].isRead
        saveToPersistence()
    }
    
    func deleteBook(at index: Int) {
        books.remove(at: index)
        saveToPersistence()
    }
    
    func saveToPersistence() {
        guard let url = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistence() {
        guard let url = readingListURL else { return }
        
        let decoder = PropertyListDecoder()
        
        do {
            let decodedBooks = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: decodedBooks)
        } catch {
            print(error)
        }
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let path = directory.appendingPathComponent("readinglist.plist")
        return path
    }
    
    var readBooks: [Book] {
        let filteredArray = books.filter({ $0.isRead == true })
        return filteredArray
    }
    
    var unreadBooks: [Book] {
        let filteredArray = books.filter({ $0.isRead == false })
        return filteredArray
    }
    
    
}
