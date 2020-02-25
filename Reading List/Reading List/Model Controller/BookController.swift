//
//  BookController.swift
//  Reading List
//
//  Created by Bhawnish Kumar on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    var books: [Book] = []
    
    
    

    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
         books.append(book)
    }
    func create(title: String, reasonToRead: String) {
    let newBook = Book(title: title, reasonToRead: reasonToRead)
        saveToPersistentStore()
    }
    var readingListURL: URL? {
        let fileMananger = FileManager.default
        
        let documentsDir = fileMananger.urls(for: .documentDirectory, in: .userDomainMask).first
        
         let booksURL = documentsDir?.appendingPathComponent("Readlist.plist") // Not working because of BOOK arrat
        
         return booksURL
    }
    
    func saveToPersistentStore() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books) // has to see with books array.
            
            guard let booksURL = readingListURL else { return }
            try booksData.write(to: booksURL)
        } catch {
            print("Unable to save into Plist \(error)")
        }
    }
        
        func loadFromPersistentStore() {
            guard let booksURL = readingListURL else { return }
            let decoder = PropertyListDecoder()
            
            do {
                let booksData = try Data(contentsOf: booksURL)
                let books = try decoder.decode([Book].self, from: booksData)
                self.books = books
                
            } catch {
                print("error decoding \(error)")
            }
        }
}

