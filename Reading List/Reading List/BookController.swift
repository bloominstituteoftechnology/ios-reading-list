//
//  BookController.swift
//  Reading List
//
//  Created by Christopher Aronson on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("readingList.plist")
    }
    
    private var readBooks: [Book] {
        let beenRead = books.filter { $0.hasBeenRead == true }
        return beenRead
    }
    
    private var unreadBooks: [Book] {
        let notBeenRead = books.filter { $0.hasBeenRead == false}
        return notBeenRead
    }
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving data to disk: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        
        guard let url = readingListURL,
        fileManager.fileExists(atPath: url.path)
        else {
            print("Could not load file")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Could not load data from file: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(newBook)
        saveToPersistentStore()
    }
    
    func deleteBook(bookToDelete: Book) {
        
        guard let bookIndex = books.firstIndex(of: bookToDelete) else { return }
        books.remove(at: bookIndex)
        
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        
        saveToPersistentStore()
    }
    
    func updateTitleAndReason(book: Book, title: String, reasonToRead: String) {
        
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        if (books[bookIndex].title != title) || (books[bookIndex].reasonToRead != reasonToRead) {
            books[bookIndex].title = title
            books[bookIndex].reasonToRead = reasonToRead
        }
        
        saveToPersistentStore()
    }
}
