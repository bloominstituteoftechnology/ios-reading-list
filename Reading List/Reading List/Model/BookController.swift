//
//  File.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {

func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenread: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
}

    func deleteBook(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }

    func updateHasBeenRead(book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        var updatedBook = books[bookIndex]
        if updatedBook.hasBeenRead == false {
            updatedBook.hasBeenRead = true
        } else {
            updatedBook.hasBeenRead = false
        }
        saveToPersistentStore()

    }
    func updateBook(book: Book, withTitle title:String, reasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        var book = books[bookIndex]
        book.title = title
        book.reasonToRead = reasonToRead
        books.remove(at: bookIndex)
        books.insert(book, at: bookIndex)

        saveToPersistentStore()
    }


    func saveToPersistentStore() {
        guard let url = readingListURL else { return }

        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving peole: \(error)")
        }
    }

    func loadFromPersistentStore() {
        //make sure file exist
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading data from disk: \(error)")
        }
    }
    var books: [Book] = []

    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true})
    }

    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false})
    }

    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}

        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("Book.Plist")

    }

}
