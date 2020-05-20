//
//  BookController.swift
//  Reading List
//
//  Created by Richard Gibbs on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController: Codable {
    var books: [Book] = []
    var readBooks: [Book]  {
        books.filter {
            $0.hasBeenRead == true
        }
    }
    var unreadBooks: [Book] {
        books.filter {
            $0.hasBeenRead == false
        }
    }
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        if  let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
    }
    func updateHasBeenRead(for book: Book) {
        if book.hasBeenRead == true {
            books.append(book)
            guard let index = books.firstIndex(of: book) else { return }
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func saveToPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: readingListURL)
        } catch {
            print("Error saving books: \(error)")
        }
    }
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            let booksPlist = try Data(contentsOf: readingListURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            self.books = decodedBooks
        } catch {
            print("Error loading books: \(error)")
        }
    }
}




