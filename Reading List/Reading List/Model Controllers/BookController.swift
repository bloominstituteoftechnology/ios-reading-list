//
//  BookController.swift
//  Reading List
//
//  Created by morse on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead }.sorted { $0.title.lowercased() < $1.title.lowercased() }
    }
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }.sorted { $0.title.lowercased() < $1.title.lowercased() }
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func createBook(named title: String, withReason reason: String) -> Book {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        print("\(unreadBooks)")
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(named book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func updateReasonOrTitle(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = book.title
        books[index].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    
    private var persistentFileURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("books.plist")
    }
    
    private func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = persistentFileURL,
            fm.fileExists(atPath: url.path) else { return }
        
        do{
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
