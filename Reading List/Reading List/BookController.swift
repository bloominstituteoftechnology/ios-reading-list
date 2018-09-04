//
//  BookController.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    private(set) var books: [Book] = []
    
    //Computed property that returns a sorted array of the read books.
    var readBooks: [Book] {
        let filteredBooks = books.filter({ (book) -> Bool in
            return book.hasBeenRead
        })
        return sortByTitle(filteredBooks)
    }
    
    //Computed property that returns a sorted array of the unread books.
    var unreadBooks: [Book] {
        let filteredBooks = books.filter({ (book) -> Bool in
            return !book.hasBeenRead
        })
        return sortByTitle(filteredBooks)
    }
    
    // MARK: - Initializers
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: CRUD Methods
    //Create method
    func createBook(title: String, reasonToRead: String, imageData: Data?) {
        let book = Book(title: title, reasonToRead: reasonToRead, imageData: imageData)
        
        books.append(book)
        saveToPersistentStore()
    }
    
    //Update methods
    //Method to toggle whether a book has been read or not
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    
    //Method to update the book's properties
    func update(_ book: Book, title: String, reasonToRead: String, imageData: Data?) {
        guard let index = books.index(of: book) else { return }
        
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        books[index].imageData = imageData
        saveToPersistentStore()
    }
    
    //Delete method
    func delete(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    //Method to encode books array and write it to disk
    private func saveToPersistentStore() {
        let pListEncoder = PropertyListEncoder()
        guard let url = readingListURL else { return }
        
        do {
            let booksData = try pListEncoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error encoding book data: \(error)")
        }
    }
    
    //Method to retrieve books data from disk and decode it
    private func loadFromPersistentStore() {
        do {
            guard let url = readingListURL, FileManager.default.fileExists(atPath: url.path) else { return }
            let booksData = try Data(contentsOf: url)
            let plistDecoder = PropertyListDecoder()
            let decodedBooks = try plistDecoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            NSLog("Error decoding book data: \(error)")
        }
    }
    
    //Computed property containing the url for the reading list plist
    var readingListURL: URL? {
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "ReadingList.plist"
        
        return documentsURL.appendingPathComponent(fileName)
    }
    
    // MARK: - Private Utility Functions
    //Method to sort books alphabetically by title.
    private func sortByTitle(_ books: [Book]) -> [Book] {
        return books.sorted(by: { (book1, book2) -> Bool in
            return book1.title < book2.title
        })
    }
}
