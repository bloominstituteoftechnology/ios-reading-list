//
//  BookController.swift
//  Reading List
//
//  Created by Ciara Beitel on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books) // encode throws a possible error, so you must put try infront of it
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let bookLoadData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: bookLoadData)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let bookToCreate = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(bookToCreate)
        saveToPersistentStore()
    }
    
    func deleteBook(bookToDelete: Book) {
        guard let index = books.firstIndex(of: bookToDelete) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for bookToUpdate: Book) {
        guard let index = books.firstIndex(of: bookToUpdate) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, withTitle: String, withReason: String) {
        guard let index = books.firstIndex(of: book) else { return }
        var updatedBook = book
        updatedBook.title = withTitle
        updatedBook.reasonToRead = withReason
        books.remove(at: index)
        books.append(updatedBook)
       saveToPersistentStore()
    }
    
    
}
