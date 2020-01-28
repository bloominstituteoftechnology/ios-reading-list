//
//  BookController.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
class BookController {
    var books = [Book]()
    
    init() {
        loadFromPersistentStore()
    }
    
    var readingListURL : URL? {
        let fm = FileManager.default
        guard let documentDirectory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let booksURL = documentDirectory.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    
    
    func saveToPersistStore() {
        guard let fileURL = readingListURL else { return }
        do {
             let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: fileURL)
        } catch  let err{
            print("Can't save books.Error : \(err)")
        }
       
    }
    
    func loadFromPersistentStore() {
        guard let fileURL = readingListURL else { return }
        do {
            let booksData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try  decoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch let err {
            print("Can't load Data , error: \(err)")
        }
    }
    func createBook(title: String, reason: String ) {
        let newBook = Book(title: title, reasonToRead: reason)
        books.append(newBook)
        saveToPersistStore()
    }
    
    func deleteBook(title:String,reason:String) {
        let book = Book(title: title, reasonToRead: reason)
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
        }
        saveToPersistStore()
        
    }
    
    func updateHasBeenRead(for book:Book)  {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead.toggle()
        saveToPersistStore()
    }
    func editBook(for books:Book) {
        //
    }
    
    
    var readBooks: [Book] {
        let readBooks =  books.filter{$0.hasBeenRead == true }
        return readBooks
    }
    var unreadBooks : [Book] {
        let unreadBooks = books.filter {$0.hasBeenRead == false }
        return unreadBooks
    }
    
}
