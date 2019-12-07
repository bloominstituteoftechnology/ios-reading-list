//
//  BookController.swift
//  Reading List
//
//  Created by Dennis Rudolph on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var delegate: ReadingListTableViewController?
   
    var books: [Book] = []
    
    var readBooks: [Book] {
        let ourBooks = books
        return ourBooks.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        let ourBooks = books
        return ourBooks.filter { $0.hasBeenRead == false }
    }
    
// Functions (CRUD)
    
    func create(bookTitle: String, reasonToRead: String) {
        let book = Book(title: bookTitle, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        delegate?.tableView.reloadData()
    }
    
    func delete(book: Book) {
        if let index = books.index(of: book) {
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
         if let index = books.index(of: book) {
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
            }
        }
       
    
    func edit(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
// Persistence Stuff
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "ReadingList.plist"
        return dir.appendingPathComponent(fileName)
    }
    
    init() {
        loadFromPersistentStore()
    }
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
        
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL,
            fm.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}

