//
//  BookController.swift
//  ReadingList
//
//  Created by Joshua Franklin on 8/20/19.
//  Copyright © 2019 AMSU. All rights reserved.
//

import Foundation

private(set) var books: [Book] = []


private var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    
    return documents.appendingPathComponent("books.plist")
}


@discardableResult func createBook(book title: String, hasRead reasonToRead: String) -> Book {
    let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
    books.append(book)
    saveToPersistentStore()
    return book
}

@discardableResult func deleteBook(book title: String, hasRead reasonToRead: String) -> Book {
    let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
    books.removeAll()
    saveToPersistentStore()
    return book
}

@discardableResult func updateHasBeenRead(book title: String, hasRead reasonToRead: String) -> Book {
    let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: true)
    saveToPersistentStore()
    return book
}

@discardableResult func updateTitle(book title: String, hasRead reasonToRead: String) -> Book {
    let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
    saveToPersistentStore()
    return book
}

func saveToPersistentStore() {
    guard let url = readingListURL else { return }
    
    do {
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(books)
        try data.write(to: url)
    } catch {
        print("Error saving books data: \(error)")
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading stars data: \(error)")
        }
    }
}
