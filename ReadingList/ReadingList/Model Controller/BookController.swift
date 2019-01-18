//
//  BookController.swift
//  ReadingList
//
//  Created by Jocelyn Stuart on 1/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation


class BookController {
    
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
    
        let finalLocation = documentsDirectory.appendingPathComponent("ReadingList.plist")
        
        return finalLocation
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
        
    }
    
    func loadFromPersistentStore() {
        guard let url = readingListURL,
            FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print(error)
        }
    }
    
    func createBook(withTitle title: String, andReason reason: String){
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        
        books[index].hasBeenRead = !books[index].hasBeenRead
        
    }
    
    func update(book: Book, title: String, reason: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reason
        
    }
    
    var readBooks: [Book] {
        let read = books.filter({ (book) -> Bool in
            return book.hasBeenRead
        })
        return read
    }
    
    var unreadBooks: [Book] {
        let unread = books.filter ({ (book) -> Bool in
            return !book.hasBeenRead
        })
        return unread
    }
    
    
    
    
    
    
    
    
    
    
    
}
