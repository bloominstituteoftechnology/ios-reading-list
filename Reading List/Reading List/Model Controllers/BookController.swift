//
//  BookController.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books[index].hasBeenRead.toggle()
        }
        saveToPersistentStore()
    }
    
    func updateTitleAndReasonToRead(for book: Book, title: String, reasonToRead: String) {
        if let index = books.firstIndex(of: book) {
            var book = books[index]
            book.title = title
            book.reasonToRead = reasonToRead
            books[index] = book
            saveToPersistentStore()
        }
    }
    
    func readBooks() -> [Book] {
        return books.filter{ $0.hasBeenRead == true }
    }
    
    func unreadBooks() -> [Book] {
        return books.filter{ $0.hasBeenRead == false }
    }
    
    // MARK: Save and Load
    func saveToPersistentStore() {
        //Star -> Data -> Plist
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let Booksdata = try encoder.encode(books)
            try Booksdata.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        //Plist -> Data -> Stars
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let Booksdata = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: Booksdata)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
    
}
