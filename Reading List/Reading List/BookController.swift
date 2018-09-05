//
//  BookController.swift
//  Reading List
//
//  Created by Farhan on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    private (set) var books: [Book] = []
    
    var readingListURL: URL? {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let fileName = "ReadingList.plist"
        
        return documentDirectory?.appendingPathComponent(fileName)
    }
    
    func saveToPersistentStorage(){
    
        let plistEncoder = PropertyListEncoder()
        
        do{
            let booksData = try plistEncoder.encode(books)
            guard let readingListURL = readingListURL else {return}
            try booksData.write(to: readingListURL)
            
        } catch {
            NSLog("Encoding Error \(error)")
        }
    
    }
    
    func loadFromPersistentStorage(){
        
        do {
            guard let readingListURL = readingListURL else {return}
            let pListData = try Data(contentsOf: readingListURL)
            
            let plistDecoder = PropertyListDecoder()
            
            let decodedBooks = try plistDecoder.decode([Book].self, from: pListData)
            
            self.books = decodedBooks
            
        } catch {
            NSLog("Decoding Error \(error)")
        }
        
    }
    
    func createBook(title: String, reason:String){
        let book = Book(title: title, reasonToRead: reason)
        books.append(book)
        saveToPersistentStorage()
    }
    
    func deleteBook(book: Book){
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStorage()
    }
    
    func updateHasBeenRead(for book: Book){
        
        if book.hasBeenRead == true {
            book.hasBeenRead = false
        } else if book.hasBeenRead == false {
            book.hasBeenRead = true
        }
        saveToPersistentStorage()
    }
    
    func updateTitleAndReason(for book: Book, title:String, reason: String){
        
        book.title = title
        book.reasonToRead = reason
        saveToPersistentStorage()
    }
    
    var readBooks: [Book] {
        let booksRead = books.filter{$0.hasBeenRead == true}
        return booksRead
    }
    
    var unreadBooks: [Book]{
        let booksUnread = books.filter{$0.hasBeenRead == false}
        return booksUnread
    }
    
    
    
    
    
    
    
}
