//
//  BookController.swift
//  Reading List
//
//  Created by Chad Parker on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []

    var readingListURL: URL? {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask).first?
            .appendingPathComponent("ReadingList.plist")
    }

    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        do {
            let booksData = try PropertyListEncoder().encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }

    func loadFromPersistentStore() {
        do {
            guard let url = readingListURL else { return }
            let data = try Data(contentsOf: url)
            books = try PropertyListDecoder().decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }

    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }

    func delete(_ book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }

    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        var book = books[index]
        book.hasBeenRead.toggle() // TODO: do I need to save back to array?
        saveToPersistentStore()
    }

    func update(_ book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        var book = books[index]
        book.title = title
        book.reasonToRead = reasonToRead // TODO: do I need to save back to array?
        saveToPersistentStore()
    }
}
