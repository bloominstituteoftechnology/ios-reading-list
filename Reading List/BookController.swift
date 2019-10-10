//
//  BookViewController.swift
//  Reading List
//
//  Created by Alex Thompson on 10/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookController {
   
    init() {
        loadFromPersistentStore()
    }
    
    func createNewBook(title: String, reasonToRead: String) {
         
        let book = Book(title: title, reasonToRead: reasonToRead)
         
        books.append(book)
        saveToPersistentStore()
         
    }
     
    var books: [Book] = []
    
    var readBooks: [Book] {
        var readBooks = books.filter {$0.hasBeenRead == true}
        readBooks.sort {
            $0.title < $1.title
        }
        return readBooks
    }
    var unreadBooks: [Book] {
        var unreadBooks = books.filter {!$0.hasBeenRead == false}
        unreadBooks.sort {
            $0.title < $1.title
        }
        return unreadBooks
    }
    
    private var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
    
    return documents.appendingPathComponent("ReadingList.plist")
    
    }

 
    func removeBook(title: Book) {
        if let index = books.index(of: title) {
            books.remove(at: index)
            
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else {return}
        books[index].hasBeenRead.toggle()
//        books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
        
        
    }
    
    func update(book: Book, withTitle title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        
        var scratch = book
        
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.insert(scratch, at: index)
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving book: \(error)")
        }
    }
    

    func loadFromPersistentStore() {
        guard let url = readingListURL else {return}
    
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
}

