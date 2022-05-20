//
//  BookController.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/19/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
//MARK: - Properties
    //All Books
    var books: [Book] = []
    //Read Books
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead }
    }
    //URL where the user's books will be saved to persist
    var readingListURL: URL? {
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
//MARK: - Methods
    
    //MARK: CRUD Methods
    //Save
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        guard let url = readingListURL else { return }
        
        do {
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("ERROR! Could not save books, error code: \(error)")
        }
        
    }
    //Load
    func loadFromPersistentStore() {
        do {
            let decoder = PropertyListDecoder()
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            self.books = decodedBooks
        } catch {
            print("ERROR! Could not retrieve books, error code: \(error)")
        }
    }
    //Create
    func newBook(title: String, reasonToRead: String) {
        let newBook = Book(title: title, reasonToRead: reasonToRead)
        books.append(newBook)
        saveToPersistentStore()
    }
    //Delete
    func removeBook(_ book: Book) {
        guard let index = books.firstIndex(of: book) else {
            print("Book not found")
            return
        }
        books.remove(at: index)
    }
    //Update
    func updateHasBeenRead(for book: inout Book) {
        book.hasBeenRead.toggle()
        saveToPersistentStore()
    }
    func updateBook(book: inout Book, newTitle: String, newReasonToRead: String) {
        book.title = newTitle
        book.reasonToRead = newReasonToRead
        saveToPersistentStore()
    }
    
} //End of class
