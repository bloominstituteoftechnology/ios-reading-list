//
//  File.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    init() {
        loadFromPersistentStore()
    }

func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
}

    func deleteBook(for book: Book) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
    }

    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    func updateBook(for book: Book, withTitle title:String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reasonToRead
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
