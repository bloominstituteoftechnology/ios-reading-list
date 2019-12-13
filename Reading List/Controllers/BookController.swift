//
//  BookController.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

import UIKit

class BookController {
    
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    
    @discardableResult func createBook(titled title: String, withReasonToRead reasonToRead: String) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        
        saveToPersistentStore()
        return book
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
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error saving book data: \(error)")
        }
    }
    
    
    func delete(which book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
        
    }
    
    func update(which book: Book, _ title: String, _ reason: String) {
        
      guard let index = books.firstIndex(of: book) else { return }
        books[index].title = title
        books[index].reasonToRead = reason
      
    }
}



