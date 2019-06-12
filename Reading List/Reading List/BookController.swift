//
//  BookController.swift
//  Reading List
//
//  Created by Kennon Keys Ward on 6/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        // Creates "/Users/ward/Documents" - documents directory path
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        // Creates "/Users/ward/Documents/stars.plist" - full file path
        return documents.appendingPathComponent("ReadingList.plist")
    }
    var readBooks: [Book] {
        var read: [Book] = []
        for x in books {
            if x.hasBeenRead == true {
                read.append(x)
            }
        }
        return read
    }
    var unreadBooks: [Book] {
        var unread: [Book] = []
        for y in books {
            if y.hasBeenRead == false {
                unread.append(y)
            }
        }
        return unread
    }
   
    
    
    func create(titled: String, reason: String) {
        let book = Book(title: titled, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
        
    }
    
    func delete(title: Book) {
        if let bookIndex = books.index(of: title) {
            books.remove(at: bookIndex)
        }
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        if book.hasBeenRead == true {
            book.hasBeenRead == false
        } else {
            book.hasBeenRead == true
        }
        saveToPersistentStore()
    }
    
    func edit(title: String, reason: String) {
        Book(title: title, reasonToRead: reason)
        
        saveToPersistentStore()
    }
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
            
        } catch {
            print("Error saving book data: \(error)")
        }
        
    }
    
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
        fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print("Error loading book data: \(error)")
        }
}

}




/*
 func loadFromPersistentStore () {
 let fileManager = FileManager.default
 guard let url = persistentFileURL,
 fileManager.fileExists(atPath: url.path) else { return }
 do {
 let data = try Data(contentsOf: url)
 let decoder = PropertyListDecoder()
 stars = try decoder.decode([Star].self, from: data)
 
 } catch {
 print("Error loadingstars data: \(error)")
 }
 
 }
 */

