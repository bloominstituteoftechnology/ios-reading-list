//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_201 on 10/4/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
    
        return documents.appendingPathComponent("ReadingList.plist")
    
    }
    
    func createNewBook(titled title: String, reasonsToRead reasonToRead: String, hasItBeenRead hasBeenRead: Bool = false) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        
        return book
    }
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving book: \(error)")
        }
    }
    
//Mark: - Check this code. ASking for decodeBooks as constant, and setting value by calling the decode Method.
    func loadFromPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
}
