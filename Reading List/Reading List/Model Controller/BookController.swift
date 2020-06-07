//
//  BookController.swift
//  Reading List
//
//  Created by Norlan Tibanear on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    
    var readingListURL: URL? {
        
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
        
    } //
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        do {
            
            let bookData = PropertyListEncoder()
            let data = try bookData.encode(books)
            try data.write(to: url)
            
        } catch {
            print("Was not able to encode data")
        }
        
    } //
    
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else { return }
        
        print(url)
        do {
            
            let data = try Data(contentsOf: url)
            let decode = PropertyListDecoder()
            let decodeBooks = try decode.decode([Book].self, from: data)
            books = decodeBooks
            
        } catch {
            NSLog("No data was save: \(error)")
        }
        
    } //
    
    
    func createBook(title: String, reasonToRead: String) {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    } //
    
    
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    } //
    
    
    // Update hasBeenRead object
    func updateHasBeenRead(for book: Book) {
        
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        saveToPersistentStore()
        
    } //
    
    
    
    //Update edit the books title and/or reasonToRead properties
    func editBook(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = "\(book.title)"
        books[index].reasonToRead = "\(book.reasonToRead)"
        saveToPersistentStore()
    }
    
    
    func updateBookData(for book: Book, title: String, reasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        var temp = book
        temp.title = title
        temp.reasonToRead = reasonToRead
        
        books.remove(at: bookIndex)
        books.insert(temp, at: bookIndex)
        
        saveToPersistentStore()
    }
    
    
    
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    
    
} // END
