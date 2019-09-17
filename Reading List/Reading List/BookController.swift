//
//  BookController.swift
//  Reading List
//
//  Created by Dennis on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
   
    // COMPUTED PROPERTIES
    
    
    var readingListURL: URL? {
       guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileName = "ReadingList.plist"
        
        return documents.appendingPathComponent("\(fileName)")
    }
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead}
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false}
    }
    
    
    // FUNCTIONS
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
            
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks

        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        let bookToRemove = book
        
        while books.contains(bookToRemove) {
            if let bookToRemoveIndex = books.index(of: bookToRemove) {
                books.remove(at: bookToRemoveIndex)
            }
        }
    }

    func updateHasBeenRead(for book: Book){
        var bookReadChange = book
        if bookReadChange.hasBeenRead != true {
            bookReadChange.hasBeenRead = true
        } else {
            bookReadChange.hasBeenRead = false
        }
    }
    
    func editBook(book: Book, newTitle: String, newReason: String) {
        var editedBook = book
        editedBook.title = newTitle
        editedBook.reasonToRead = newReason
    }


}
