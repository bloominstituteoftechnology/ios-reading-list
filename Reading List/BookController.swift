//
//  BookController.swift
//  Reading List
//
//  Created by Daniela Parra on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    //Create book.
    
    //Delete book.
    
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
    
    private(set) var books: [Book] = []
}
