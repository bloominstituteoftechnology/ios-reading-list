//
//  BookController.swift
//  Reading List
//
//  Created by Daniela Parra on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() { loadFromPersistentStore() }
    
    //Create book.
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
    }
    
    //Delete book.
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        
        saveToPersistentStore()
    }
    
    //Update hasBeenRead property
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else { return }
        
        var scratch = book
        let newStatus = !book.hasBeenRead
        scratch.hasBeenRead = newStatus
        
        books.remove(at: index)
        books.insert(scratch, at: index)
        
        saveToPersistentStore()
    }
    
    //Update title and reasonToRead properties
    func update(book: Book, title: String, reasonToRead: String){
        guard let index = books.index(of: book) else { return }
        
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        
        saveToPersistentStore()
    }
    
    //Encode books array to data.
    private func saveToPersistentStore() {
        let plistEncoder = PropertyListEncoder()
        
        do {
            let booksData = try plistEncoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            
            try booksData.write(to: readingListURL)
            
        } catch {
            NSLog("Error encoding books: \(error)")
        }
    }
    
    private func loadFromPersistentStore() {
        
        do {
            guard let readingListURL = readingListURL else { return }
            
            let booksData = try Data.init(contentsOf: readingListURL)
            
            let plistDecoder = PropertyListDecoder()
            
            let decodedBooks = try plistDecoder.decode([Book].self, from: booksData)
            
            books = decodedBooks
            
        } catch {
            NSLog("Error decoding book: \(error)")
        }
    }
    
    var readingListURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "ReadingList.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    var readBooks: [Book] {
        return books.filter{$0.hasBeenRead}
    }
    var unreadBooks: [Book] {
        return books.filter{!$0.hasBeenRead}
    }
    private(set) var books: [Book] = []
}
