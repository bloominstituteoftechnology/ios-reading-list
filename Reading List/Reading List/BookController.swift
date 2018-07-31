//
//  BookController.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    func saveToPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("\(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            NSLog("\(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        books.append(Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead))
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
    }
    
    func updateReadStatus(for book: Book) {
        guard let index = books.index(of: book) else { return }
        books[index].hasBeenRead = !(books[index].hasBeenRead)
    }
    
    func updateBookTitle(for book: Book, title: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = title
    }
    
    func updateReasonToRead(for book: Book, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].reasonToRead = reasonToRead
    }
    
    // MARK: - Properties
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let documentDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documentDir.appendingPathComponent("ReadingList.plist")
    }
    
    private(set) var books: [Book] = []
}
