//
//  BookController.swift
//  Reading List
//
//  Created by Jeremy Taylor on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // MARK: - Properties
    
    private(set) var books: [Book] = []
    
   private var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
    }
    print("Documents: \(documents.path)")
    return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        let read = books.filter({$0.hasBeenRead == true})
        return read
    }
    
    var unreadBooks: [Book] {
        let read = books.filter({$0.hasBeenRead == false})
        return read
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading books: \(error)")
        }
    }
    
    func createBook(withTitle title: String, and reansonToRead: String) {
        let book = Book(title: title, reasonToRead: reansonToRead)
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
        
        var tempBook = book
        tempBook.hasBeenRead.toggle()
        
        books.remove(at: index)
        books.insert(tempBook, at: index)
        saveToPersistentStore()
    }
    
    func updateBookInfo(for book: Book, withTitle title: String, andReasonToRead reason: String) {
        guard let index = books.index(of: book) else { return }
        
        var tempBook = book
        tempBook.title = title
        tempBook.reasonToRead = reason
        books.remove(at: index)
        books.insert(tempBook, at: index)
        saveToPersistentStore()
    }
}
