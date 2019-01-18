//
//  BookController.swift
//  Reading List
//
//  Created by Dustin Koch on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: - Make app persistent
    
    private var persistentFileURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let finalLocation = documentsDirectory.appendingPathComponent("books.plist")
        
        return finalLocation
    }
    
    func saveToPersistentStore() {
        guard let url = persistentFileURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }

    func loadFromPersistentStore() {
        guard let url = persistentFileURL else { return }
        guard FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            try books = decoder.decode([Book].self, from: data)
        } catch {
            print(error)
        }
        
    }
    
    //MARK: - Functions for book array
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
        
    }
    
    func updateHasBeenRead(for book: Book) {
        
        guard let index = books.index(of: book) else { return }
        let status: Bool = books[index].hasBeenRead
        
        if status == true {
            books[index].hasBeenRead = false
        } else {
            books[index].hasBeenRead = true
        }
        saveToPersistentStore()
    }
    
    func updateTitleOrReason(for book: Book, newTitle: String?, newReason: String?) {
        //edit the Book's title and/or reasonToRead properties
        guard let index = books.index(of: book) else { return }
        
        guard let newestTitle = newTitle, newTitle != "" else { return }
        guard let newestReason = newReason, newReason != "" else { return }
        
        if newestTitle == newTitle {
            books[index].title = newestTitle
        }
        if newestReason == newestReason {
            books[index].reasonToRead = newestReason
        }
        saveToPersistentStore()
    }
    
    //MARK: - Multiple sections in tableview
    
    var readBooks: [Book] {
        var readBookList: [Book] = []
        
        for eachBook in books {
            if eachBook.hasBeenRead == true {
                readBookList.append(eachBook)
            }
        }
        return readBookList
    }
    
    var unreadBooks: [Book] {
        var unreadBookList: [Book] = []
        
        for eachBook in books {
            if eachBook.hasBeenRead == false {
                unreadBookList.append(eachBook)
            }
        }
        return unreadBookList
    }
    
    
    
    
}


