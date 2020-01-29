//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Losaner_256 on 1/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation



class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    var books = [Book]()
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return nil }
        
        return documents.appendingPathComponent("books.plist")
    }
    
    @discardableResult func createBook(named title: String, withReason reasonToRead: String) -> Book {
        let book = Book(title: name, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
   
    func removeBook(named book:Book) {
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
    
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
            return readBooks
        }
    
    var unreadBooks: [Book] {
        let unreadBooks  = books.filter { $0.hasBeenRead == false }
            return unreadBooks
    }
    
    
    
    
    
        func saveToPersistentStore() {
        
        //        guard let url = persistentFile
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
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}





