//
//  BookController.swift
//  Reading List
//
//  Created by Brian Rouse on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        let readBooksArray = books.filter {$0.hasBeenRead == true}
        return readBooksArray
    }
    
    var unreadBooks: [Book] {
        let unreadBooksArray = books.filter {$0.hasBeenRead == false}
        return unreadBooksArray
    }
    
    
    init() {
        loadToPersistantStore()
    }
    
    
    
    func createBook (named name: String, reason reasonToRead: String, hasBeenRead: Bool = false) {
        let newBook = Book(title: name, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(newBook)
        saveToPersistantStore()
    }
    
    func deleteBook (bookToDelete: Book) {
        var index = 0
        for book in books {
            if book.title == bookToDelete.title {
                books.remove(at: index)
            }else{
                index += 1
            }
        }
        saveToPersistantStore()
    }
    
    
    
    func updateHasBeenRead(for bookToUpdate: Book) {
        var index = 0
        for book in books {
            if book.title == bookToUpdate.title {
                books[index].hasBeenRead.toggle()
            }else {
                index += 1
            }
        }
        saveToPersistantStore()
    }
    
    func updateBook(for bookToUpdate: Book, newName name:String, newReason reasonToRead: String) {
        var index = 0
        for book in books {
            if book.title == bookToUpdate.title {
                books[index].title = name
                books[index].reasonToRead = reasonToRead
            } else {
                index += 1
            }
        }
        saveToPersistantStore()
    }
    
    
    func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        do{
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("error saving books data: \(error)")
        }
    }
    
    func loadToPersistantStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        do {
            let bookData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: bookData)
            books = decodeBooks
        } catch {
            print("error loading books data: \(error)")
        }
    }
    
}
