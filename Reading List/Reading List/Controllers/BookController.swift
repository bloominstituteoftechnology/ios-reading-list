//
//  BookController.swift
//  Reading List
//
//  Created by David Williams on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
        init() {
            loadFromPersistentStore()
        }
    let readBooks: [Book] = books.filter {_ in book.hasBeenRead }
    let unreadBooks: [Book] = books.filter {_ in !book.hasBeenRead }
    var books: [Book] = []
    
     var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        // Data in Plist -> Book
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        do {
            let booksData =  try Data(contentsOf: url)
            let decodedBooks = PropertyListDecoder()
            books =  try decodedBooks.decode([Book].self, from: booksData)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    @discardableResult func createBook(named name: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
            let book = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
            books.append(book)
            saveToPersistentStore()
            return book
        }
    
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    #warning("hopefully this works")
    func updateHasBeenRead(for book: Book) {
        let readBooks: [Book] = books.filter {_ in book.hasBeenRead }
        let unreadBooks: [Book] = books.filter {_ in !book.hasBeenRead }
        saveToPersistentStore()
    }
    #warning("Not sure if this will work")
    func editBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title =  book.title //""//"\(bookTitleLabel)"
        books[index].reasonToRead = book.reasonToRead //""//"\(reasonToReadLabel)"
        saveToPersistentStore()
    }

}
