//
//  BookController.swift
//  Reading List
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistence()
    }
    
    func createBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistence()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead = book.hasBeenRead
        saveToPersistence()
    }
    
    func updateTitleReasonToRead(for book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistence()
    }
    
    func deleteBook(at index: Int) {
        books.remove(at: index)
        saveToPersistence()
    }
    
    func saveToPersistence() {
        
        guard let url = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistence() {
        
        do {
            guard let url = readingListURL else { return }
            let decoder = PropertyListDecoder()
            let decodedBooks = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: decodedBooks)
        } catch {
            print(error)
        }
        
    }
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        // access file manager
        let fileManager = FileManager.default
        // get directory from file manager
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        // add new path
        let finalLocation = documentsDirectory.appendingPathComponent("ReadingList.plist")
        // return to URL
        return finalLocation
    }
    
    var readBooks: [Book] {
        let filteredArray = books.filter({ $0.hasBeenRead == true })
        return filteredArray
    }
    
    var unreadBooks: [Book] {
        let filteredArray = books.filter({ $0.hasBeenRead == false })
        return filteredArray
    }
    
}
