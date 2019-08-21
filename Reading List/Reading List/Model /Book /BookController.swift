//
//  BookController.swift
//  Reading List
//
//  Created by brian vilchez on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
class BookController  {
    
    //MARK: - Properties
   private(set) var books: [Book] = []
    var readBooks:[Book] {
        var readBooks = books.filter({$0.hasBeenRead == true})
        return readBooks
    }
    var unreadBooks:[Book] {
        var unreadBooks = books.filter({$0.hasBeenRead == false})
        return unreadBooks
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: - Methods
    func addBook(withTitle title:String, reasonToRead reason: String ) {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
            var updateBook = book
        updateBook.hasBeenRead = !updateBook.hasBeenRead
    }
    
    func updateBook(withTitle title: String, reasonToRead reason: String) {
        var updateBook: Book?
        updateBook?.reasonToRead = reason
        updateBook?.title = title
    }
    
    func deleteBook(_ indexPath:Int) {
        books.remove(at: indexPath)
    }
}

// created extension for persistance
extension BookController {
    
    var readingLIstURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectoy = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectoy.appendingPathComponent("readingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingLIstURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingLIstURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
}
