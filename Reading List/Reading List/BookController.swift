//
//  BookViewController.swift
//  Reading List
//
//  Created by Alex Thompson on 10/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookController {
    private(set)var books: [Book] = []
    
    private var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documents = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else { return nil }
    
    return documents.appendingPathComponent("ReadingList.plist")
    
    }

    func createNewBook(title: String, reasonToRead: String) {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
        saveToPersistentStore()
        
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

