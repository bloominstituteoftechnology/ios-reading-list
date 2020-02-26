//
//  BookController.swift
//  Reading List
//
//  Created by Bradley Diroff on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    var readingListURL: URL? {
        
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let readingURL = documentsDirectory?.appendingPathComponent("ReadingList.plist")
        return readingURL
        
    }
    
    var readBooks: [Book] {
        let readOnes = books.filter{ $0.hasBeenRead == true }
        let sortArray = readOnes.sorted{ $0.title < $1.title }
        return sortArray
    }
    
    var unreadBooks: [Book] {
        let unreadOnes = books.filter{ $0.hasBeenRead == false }
        let sortArray = unreadOnes.sorted{ $0.title < $1.title }
        return sortArray
    }
    
    func createBook(with title: String, reason: String) {
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(with book: Book) {
        if let index = books.firstIndex(where: {$0.title == book.title}){
            books.remove(at: index)
        }
        saveToPersistentStore()
    }
    
    func updateRead(with book: Book) {
        if let index = books.firstIndex(where: {$0.title == book.title}){
            books[index].hasBeenRead = true
        }
        saveToPersistentStore()
    }
    
    func updateTitleOrReasson(with book: Book, title: String? = nil, reason: String? = nil){
        
        if let index = books.firstIndex(where: {$0.title == book.title}){
            if let newTitle = title {
                books[index].title = newTitle
            }
            if let newReason = reason {
                books[index].reasonToRead = newReason
            }
        }
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        do {
            let readingPlist = try encoder.encode(books)
            guard let readingURL = readingListURL else {return}
            
            try readingPlist.write(to: readingURL)
            
        } catch {
            print("Unable to run: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let readingURL = readingListURL else {return}
        
        let decoder = PropertyListDecoder()
        
        do {
            
            let readingData = try Data(contentsOf: readingURL)
            let readingArray = try decoder.decode([Book].self, from: readingData)
            
            self.books = readingArray
            
        } catch {
            print("An error occured: \(error)")
        }
    }
}
