//
//  BookController.swift
//  Reading List
//
//  Created by Vici Shaweddy on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter { (book) -> Bool in
            return book.hasBeenRead
        }
    }
    
    var unreadBooks: [Book] {
        return books.filter { (book) -> Bool in
            return book.hasBeenRead == false
        }
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    @discardableResult func create(named name: String, reasoned reasonToRead: String, readStatus hasBeenRead: Bool ) -> Book {
        
        let book = Book(name: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        let offset = books.distance(from: books.startIndex, to: index)
        books.remove(at: offset)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        var book = book
        book.hasBeenRead.toggle()
    }
    
    func edit(book: Book) {
//        var book = book
        //text field
//        book.name =
//        book.reasonToRead =
//        self.saveToPersistentStore()

    }
    
    // responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application
    private func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving books data: \(error)")
        }
    }
    
    //responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc
    private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
