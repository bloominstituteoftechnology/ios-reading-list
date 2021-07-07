//
//  BookController.swift
//  Reading List
//
//  Created by Ryan Murphy on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
   
   
    init() {
        loadFromPersistentStore()
    }
    //crud
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    func createBook( title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(newBook)
        saveToPersistentStore()
    }
    func updateHasBeenRead(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, newTitle title: String, NewReason reason: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reason
        saveToPersistentStore()
    }
    //Persistence
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        //if you need to find the path
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("books.plst")
    }

    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error Saving Book: \(error)")
        }
    }

    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let decodeBooks = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: decodeBooks)
        } catch {
            print("Error Decoding Books: \(error)")
        }
    }
    //Properties
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead})
    }
    var unreadBooks: [Book] {
        return books.filter({ !$0.hasBeenRead})
    }

    var books: [Book] = []

}

