//
//  BookController.swift
//  Reading List
//
//  Created by Carolyn Lea on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController
{
    private(set) var books = [Book]()
    //var book: Book?
    
//    init()
//    {
//        loadFromPersistentStore()
//    
//    }
    
    var readBooks: [Book]
    {
        let readArray = books.filter { $0.hasBeenRead == true }
        return readArray
//        return self.readBooks.filter({ $0.hasBeenRead == true})

    }
    
    var unreadBooks: [Book]
    {
        let unreadArray = books.filter { $0.hasBeenRead == false }
        return unreadArray
//        return self.unreadBooks.filter({ $0.hasBeenRead == false})

    }
    
    
    
    private var readingListURL: URL?
    {
        let fileManager = FileManager.default
        
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    
    func saveToPersistentStore()
    {
        guard let url = readingListURL else {return}
        
        do
        {
           let encoder = PropertyListEncoder()
           let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        }
        catch
        {
            NSLog("Error saving books data: \(error)")
        }
    }
    
    func loadFromPersistentStore()
    {
        let fileManager = FileManager.default
        
        do
        {
            guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {return}
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        }
        catch
        {
            NSLog("Error saving books data: \(error)")
        }
    }
    
    func createBook(title: String, reasonToRead: String)
    {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        print(book)
        saveToPersistentStore()
        
    }
    
    func deleteBook(book: Book)
    {
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book)
    {
        var book = book
        //guard let index = books.index(of: book) else {return}
        book.hasBeenRead = !book.hasBeenRead
        //books[index].hasBeenRead = !books[index].hasBeenRead
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, title: String, reasonToRead: String)
    {
        if let index = books.index(of: book)
        {
            var tempBook = book
            tempBook.title = title
            tempBook.reasonToRead = reasonToRead
            
            books.remove(at: index)
            books.insert(book, at: index)
            saveToPersistentStore()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
