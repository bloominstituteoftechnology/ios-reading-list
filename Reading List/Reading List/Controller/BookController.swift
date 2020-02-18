//
//  BookController.swift
//  Reading List
//
//  Created by Breena Greek on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter ({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter ({$0.hasBeenRead == false})
    }
    
    
    //CRUD
    func createBook(title: String,reasonToRead: String){
        let book = Book(title: title, reasonToRead: reasonToRead)
            books.append(book)
            saveToPersistentStore()
        }
    
    func deleteBook(_ book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
            books.remove(at: index)
            saveToPersistentStore()
        }
    
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let booksURL = documents.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    
    func saveToPersistentStore() {
        
        // Books -> Data -> Plis
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Books
        guard let url = readingListURL else { return }
        
        do {
            let decoder = PropertyListDecoder()
            let booksData = try Data(contentsOf: url)
            let booksArray = try decoder.decode([Book].self, from: booksData)
            self.books = booksArray
            
        } catch {
            print("error loading stars data: \(error)")
            
        }
    }
    
    func updateeHadBeenRead(for book: Book) {
        guard let updateRead = books.firstIndex(of: book) else { return }
        books[updateRead].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
    func titleAndReasonToRead(for book: Book) {
        guard let titleOrReasonToRead = books.firstIndex(of: book) else { return }
        books[titleOrReasonToRead].title = book.title
        books[titleOrReasonToRead].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    
    func editBook(book: Book, title: String) {
        guard let bookEdit = books.firstIndex(of: book) else { return }
        var tempBook = book
        tempBook.title = book.title
        books.remove(at: bookEdit)
        books.insert(tempBook, at: bookEdit)
        saveToPersistentStore()
    }
}
