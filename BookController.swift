//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_268 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    var fileManager = FileManager.default
    var books: [Book] = []
    var readingListURL:URL? {
           let paths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
           let documentsDirectory = paths[0]
           let  identityString = "ReadingList.plist"
           let  newURL = documentsDirectory.appendingPathComponent(identityString)
           return newURL
    
        
    }
    
    var readBooks: [Book] {
        books.filter { $0.hasBeenRead == true }
    }
    var unreadBooks: [Book] {
        books.filter { $0.hasBeenRead == false }
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let booksData: Data = try encoder.encode(books)
            try booksData.write(to: readingListURL!)
        } catch {
            print("Error: There's no data to encode.")
        }
        
    }
    func loadFromPersistentStore() {
        let decoder = PropertyListDecoder()
        guard let unwrappedReadingListURL = readingListURL else { return }
        do {
                let propertyListForm = try Data(contentsOf: unwrappedReadingListURL)
                let decodedBooks = try decoder.decode([Book].self, from: propertyListForm)
                self.books = decodedBooks
        } catch {
            print("There's nothing to load!")
        }
    }
    
    // Create
    func Create(title: String, reasonToRead: String, hasBeenRead: Bool) {
        var book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    // Delete
    func delete(_ Book: Book) //The Book belongs to the class.
    {
        
        guard let index = books.firstIndex(of: Book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    
    }
    
    // Update 1
    func updateHasBeenRead(for book: Book) {
        var newBook = Book(title: book.title, reasonToRead: book.reasonToRead, hasBeenRead: book.hasBeenRead)
        if newBook.hasBeenRead == true {
            newBook.hasBeenRead = false
            
        } else {
            newBook.hasBeenRead = true
        }
        delete(book)
        books.append(newBook)
        saveToPersistentStore()
    }
    // Update 2
    func changeTitleOrReasonToRead(for book: Book, newTitle: String?, newReasonToRead: String?) {
        var newBook = Book(title: book.title, reasonToRead: book.reasonToRead, hasBeenRead: book.hasBeenRead)
        guard let newTitle = newTitle else { return }
            newBook.title = newTitle
        guard let newReasonToRead = newReasonToRead else { return }
            newBook.reasonToRead = newReasonToRead
        delete(book)
        books.append(newBook)
        saveToPersistentStore()
        
    }
    
    
    
}

