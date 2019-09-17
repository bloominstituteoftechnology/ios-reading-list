//
//  BookController.swift
//  Reading List
//
//  Created by Jonalynn Masters on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
class BookController {
    //MARK: init to open the app from the persistent store
    init () {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []

    private var readingListURL: URL? {
        let filemanager = FileManager.default
        guard let documents = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("readingList.plist")
    }
    
    // MARK: Initialize new book object
    @discardableResult func createBook(named name: String, withReason reason: String, withRead beenReadStatus: Bool) ->
        Book {
            let book = Book(title: name, reasonToRead: reason, hasBeenRead: beenReadStatus)
            books.append(book)
            saveToPersistentStore()
            return book
    }
    
    //MARK: Delete a book method
    func deleteBook(book: Book) {
    guard let index = books.firstIndex(of: book) else { return }
    books.remove(at: index)
        saveToPersistentStore()
    }
    
    //MARK: two methods for updating: one to update hasBeenRead status and one to update title and reasonToRead
    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        if books[index].hasBeenRead == false {
            books[index].hasBeenRead = true
        } else if books[index].hasBeenRead == true {
            books[index].hasBeenRead = false
        }
        saveToPersistentStore()
    }
    
    func updateTitleOrReasonToRead(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
    
    //MARK: function responsible for saving any changes to any book object so that the changes will still be there when the user comes back into the app
    func saveToPersistentStore() {
        // readingList > Data > PList
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)            
       // writing data to readingList.plist
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    //MARK: function that grabs the property list stored on the device, and converts the info in it back into an array of book objects to display in table view
    func loadFromPersistentStore() {
        //PList > Data > Stars
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let booksData = try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books = try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    //MARK: Computed property to return an array of books based on their hasBeenRead status
       var readBooks: [Book] {
        let readBooks: [Book] = books.filter({ $0.hasBeenRead })
        return readBooks
    }
    
    var unReadBooks: [Book] {
        let unReadBooks: [Book] = books.filter({!$0.hasBeenRead})
        return unReadBooks
    }
}
