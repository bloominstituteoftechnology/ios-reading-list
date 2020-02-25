//
//  BookController.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {

    var books: [Book] = []
    
    var readBooks: [Book] {
        get {
            let read: [Book] = books.filter { book in book.hasBeenRead}
            let sorted: [Book] = read.sorted {book1, book2 in
                book1.title.lowercased() < book2.title.lowercased()
            }
            
            return sorted
        }}

    var unreadBooks: [Book] {
        get {
            let unRead: [Book] = books.filter { book in !book.hasBeenRead}
            let sorted: [Book] = unRead.sorted {book1, book2 in
                book1.title.lowercased() < book2.title.lowercased()
            }
            
            return sorted
        }}
    

    var readingListURL: URL? {
            get {     
                let fileManager = FileManager.default
                guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
                let plistFile = documentsDir.appendingPathComponent("ReadingList.plist")
                
                return plistFile
            } }
    
// MARK: - PropertyListEncoder
    
    func saveToPersistentStore() {
        
        guard let fileUrl = readingListURL else { return }
        let propertyList = PropertyListEncoder()
        
        do {
            let booksData = try propertyList.encode(books)
            try booksData.write(to: fileUrl)
        } catch {
            print("Error encoding Book: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let fileUrl = readingListURL else { return }
            let data = try Data(contentsOf: fileUrl)
            let plistDecoder = PropertyListDecoder()
            let decodedBooks = try plistDecoder.decode([Book].self , from: data)
            books = decodedBooks
            
        } catch {
            print("Failed to load decoded books array: \(error)")
        }
    }
    
// MARK: - CRUD Methods
    
    func create(title: String, reasonToRead: String, image: Image? ) {
        if let image = image {
            var newBook = Book(title: title, reasonToRead: reasonToRead)
            newBook.image = image
            books.append(newBook)
        } else {
            books.append(Book(title: title, reasonToRead: reasonToRead))
        }
        
        saveToPersistentStore()
    }
    
    func delete(for book: Book) {
        guard let i = books.firstIndex(of: book) else { return }
        print(books[i].title)
        books.remove(at: i)
        
    }
    
    func updateHasBeenRead(for book: Book) {
        for i in 0..<books.count {
            if books[i] == book {
                books[i].hasBeenRead.toggle()
                print(books)
            }
        }
    }
    
    func update(for book: Book, title: String, reasonToRead: String, image: Image?) {
        
        for i in 0..<books.count {
            if books[i] == book {
                books[i].title = title
                books[i].reasonToRead = reasonToRead
                if let image = image {
                    books[i].image = image
                }
            }
        }
    }
    
}
