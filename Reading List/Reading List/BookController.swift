//
//  BookController.swift
//  Reading List
//
//  Created by morse on 4/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        let readbooks = books.filter { $0.hasBeenRead }
        return readbooks
    }
    
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { !$0.hasBeenRead }
        return unreadBooks
    }
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let fileName = "ReadingList.plist"
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let location = documentDirectory.appendingPathComponent(fileName)
        return location
    }
    
    init() {
        loadFromPersistantStore()
    }
    
    func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistantStore() {
        guard let url = readingListURL, FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Failed to load books from the file system. Error: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistantStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        //    if let questionIndex = questions.firstIndex(of: question) {
        //        questions.remove(at: questionIndex)
        //    }
        // or ^ ?
        saveToPersistantStore()
    }
    
    func editBook(called book: Book, title: String?, reasonToRead: String?) {
        guard let index = books.firstIndex(of: book) else { return }
        if let title = title {
            books[index].title = title
        }
        if let reasonToRead = reasonToRead {
            books[index].reasonToRead = reasonToRead
        }
//        Same question as deleteBook ^^^
        saveToPersistantStore()
    }
    
    func updateHasBeenRead(of book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        switch books[index].hasBeenRead {
        case true:
            books[index].hasBeenRead = false
        case false:
            books[index].hasBeenRead = true
        }
        //        Same question as deleteBook ^^^
        saveToPersistantStore()
    }
    
}
