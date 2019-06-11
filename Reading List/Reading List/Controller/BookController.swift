//
//  BookController.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    //
    // MARK: - Properties
    //
    
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadToPersistantStore()
    }
    
    //
    // MARK: - Methods
    //
    
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
    }
    
    func saveToPersistantStore() {
        guard let url = readingListURL else { return }
        let encoder = PropertyListEncoder()
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("error saving books data: \(error)")
        }
    }
    
    func loadToPersistantStore() {
        do {
            guard let url = readingListURL else { return }
            let bookData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: bookData)
            books = decodeBooks
        } catch {
            print("error loading books data: \(error)")
        }
    }
    
}
