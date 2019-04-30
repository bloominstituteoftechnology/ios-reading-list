//
//  BookController.swift
//  Reading List
//
//  Created by Thomas Cacciatore on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
//
//    func updateHasBeenRead(for book: Book) {
//        if book.hasBeenRead == true {
//            book.hasBeenRead = false
//        } else {
//            book.hasBeenRead = true
//        }
//    }
//
//    func editBook() {
//
//    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
    
    
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
    
        do {
            let data = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: data)
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
      let read = books.filter({ $0.hasBeenRead == true })
        return read
    }

    var unreadBooks: [Book] {
     let unread = books.filter({ !$0.hasBeenRead == false })
        return unread
    }
}


