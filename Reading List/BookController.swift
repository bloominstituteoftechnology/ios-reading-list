//
//  BookController.swift
//  Reading List
//
//  Created by Zack Larsen on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    init() {
      loadFromPersistentStore()
        
    }
    
    func createBook(with title: String, reasonToRead: String, hasBeenRead: Bool ) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()

    }
    
    func delete(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }

    func updateHasBeenRead(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
         saveToPersistentStore()
    }
    
    func updateReasonToRead(with title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
//    Create a computed property called readBooks: [Book]. Inside of the closure of the computed property, you will need to return an array of all of the Book objects from the books array whose hasBeenRead property is true. The easiest way to do that is by using the .filter higher-order function. If you are unfamiliar with this function, read the part of this article titled "Filter". If you still have questions, please ask in the help channel for your cohort, and a PM will explain it to you in more depth.
//    Create a similar computed property called unreadBooks: [Book] that does the same thing, except it returns an array of Books whose hasBeenRead property is false.
     
    var readBooks: [Book] {
        
        return books.filter({$0.hasBeenRead})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
    
//    let digits = [1,4,10,15]
//    let even = digits.filter { $0 % 2 == 0 }
//
    
    
    
    
private var readingListURL: URL? {
    let fileManager = FileManager.default
    
    guard let documentsDir = fileManager.urls( for: .documentDirectory, in: .userDomainMask).first else {
        return nil }
    
    return documentsDir.appendingPathComponent("ReadingList.plist")
    
}

func saveToPersistentStore() {
    
    let encoder = PropertyListEncoder()
    
    do {
        let booksData = try encoder.encode(books)
        
        guard let fileURL = readingListURL else { return }
        
        try booksData.write(to: fileURL)
        
    } catch let bookError {
        print("Error saving books: \(bookError)")
    }
}

    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let fileURL = readingListURL,
            fileManager.fileExists(atPath: fileURL.path) else {
                return }
        
        do {
            let decodedBooks = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: decodedBooks)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
