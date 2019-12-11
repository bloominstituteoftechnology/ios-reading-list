//
//  BookController.swift
//  Reading List
//
//  Created by Morgan Smith on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        let readBooksArray = books.filter({ $0.hasBeenRead == true})
        return readBooksArray
    }
    
    var unreadBooks: [Book] {
        let unreadBooksArray = books.filter({ $0.hasBeenRead == false})
        return unreadBooksArray
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving reading list data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("error loading reading list data: \(error)")
        }
    }
    
    func Create(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func Delete(book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        var newBook = book
        if newBook.hasBeenRead == true {
            newBook.hasBeenRead = false
        } else {
            newBook.hasBeenRead = true
        }
        saveToPersistentStore()
    }
    
    func updateBookProperties(book: Book, newTitle: String?, newReasonToRead: String?) -> Book {
        var newBook = book
        if let updateTitle = newTitle {
            newBook.title = updateTitle
        }
        if let updateReason = newReasonToRead {
            newBook.reasonToRead = updateReason
        }
        saveToPersistentStore()
        return newBook
    }
}
