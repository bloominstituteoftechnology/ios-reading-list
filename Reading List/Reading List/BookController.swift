//
//  BookController.swift
//  Reading List
//
//  Created by Craig Belinfante on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let readingListURL = documentsDirectory?.appendingPathComponent("ReadingListURL.plist")
        return readingListURL
    }
    
    func saveToPersistentStore () {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: readingListURL!)
        } catch {
            print("Error")
        }
    }
    
    func loadFromPersistentStore () {
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: readingListURL!)
            books = try decoder.decode([Book].self, from: data)
        } catch  {
            print("loadPersistentStore \(error)")
        }
    }
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    func deleteBook(book: Book) {
        guard let index: Int = books.firstIndex(of: book) else {return}
        
        books.remove(at: index)
        saveToPersistentStore()
        
    }
    
    func updateHasBeenRead(book: Book) {
        guard let index: Int = books.firstIndex(of: book) else {return}
        books[index].hasBeenRead.toggle()
        
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, title: String, reasonToRead: String) {
        guard let index: Int = books.firstIndex(of: book) else {return}
        
        var myBook = book
        myBook.title = title
        myBook.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(myBook, at: index)
        saveToPersistentStore()
    }
}
