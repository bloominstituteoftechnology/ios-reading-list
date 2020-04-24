//
//  BookeController.swift
//  Reading List
//
//  Created by brian vilchez on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
   private(set) var books = [Book]()
    
    init() {
        loadFromPersistStore()
    }
    
    func createNewBook(Title: String,reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: Title, reasonToRead: reasonToRead, hasbeenRead: hasBeenRead)
        books.append(book)
        return book
    }
    
}

extension BookController {
    
     private var readingList: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil }
            return directory.appendingPathComponent("Books.Plist")
        }
    
    
    // MARK: Persistence
    func  saveToPersistStore() {
        guard let url = readingList else {return}
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            NSLog("\(error)")
        }

    }
    
    func loadFromPersistStore() {
        let fm = FileManager.default
        guard let url = readingList, fm.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
                NSLog("\(error)")
            }
        }
    }
    

