//
//  BookController.swift
//  Reading List
//
//  Created by Eoin Lavery on 10/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookController {
    
    //Books array to hold file loaded fron localStorage
    private(set) var books: [Book] = []
    
    //Initializer to get data when BookController instance is created
    init() {
        loadFromPersistentStore()
    }
    
    //Gets URL for localStorage file holding data for persistence
    var readingListURL: URL? {
        let fileManager = FileManager()
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    //Creates readBooks array for Books with a .hasBeenRead value of true
    var readBooks: [Book] {
        var readBooks = books.filter { $0.hasBeenRead == true }
        readBooks = readBooks.sorted {
            $0.title < $1.title
        }
        return readBooks
    }
    
    //Creates unreadBooks array for Books with a .hasBeenRead value of false
    var unreadBooks: [Book] {
        var unreadBooks = books.filter {$0.hasBeenRead == false}
        unreadBooks = unreadBooks.sorted {
            $0.title < $1.title
        }
        return unreadBooks
    }
    
    //Saves Books array to localStorage file for persistence
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books to file: \(error)")
        }
    }
    
    //Loads data from localStorage file to Books array for use within app
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data.init(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error retrieving books from file: \(error)")
        }
    }
    
    //Creates a new book, adds to array and then saves to localStorage file
    func createBook(title: String, reasonToRead: String) {
        let bookToCreate = Book(title: title, reasonToRead: reasonToRead)
        books.append(bookToCreate)
        saveToPersistentStore()
    }
    
    //Deletes selected book from array and saves updated array to localStorage file
    func deleteBook(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    //Handles method to update hasBeenRead property of a selected book, and updates localStorage file
    func updateHasBeenRead(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    //Stores newly updated information entered for a specific book, and updates localStorage file
    func updateBookInfo(for book: Book, newTitle: String, newReasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = newTitle
        books[index].reasonToRead = newReasonToRead
        saveToPersistentStore()
    }
}
