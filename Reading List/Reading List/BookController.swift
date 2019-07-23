//
//  BookController.swift
//  Reading List
//
//  Created by admin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
   
    var books = [Book]()
    
    
    
    func saveToPersistenceStore() {
        guard let url = readListURL else { return }
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    func createBooks(withName title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistenceStore()
        
        return book
    }
    
        func deleteBooks(book: Book) {
        
            guard let bookToBeDeletedIndex = books.firstIndex(of: book) else { return }
            books.remove(at: bookToBeDeletedIndex)
            saveToPersistenceStore()
        
    }
    
    func updateHasBeenRead(for book: Book) {
        
    }
    
    func loadFromPersistenStore() {
        do {
            guard let url = readListURL else { return }
            let data = try Data(contentsOf: url)
            let decodeBooks = PropertyListDecoder()
            books = try decodeBooks.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    private var readListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
}
