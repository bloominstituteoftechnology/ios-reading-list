//
//  BookController.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

//greatest hierarchy
class BookController {
  
    //Empty array of Book object
    private(set) var books: [Book] = []
    
    

//Navigation to the file path
    private var persistentFileURL: URL? {
    //iPhone file system
        let fileManager = FileManager.default
    //finding the first url
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    //coercing to books.plist
        return documents.appendingPathComponent("ReadingList.plist")
}

    func savetoPersistenStore() {
        
        guard let url = persistentFileURL else { return }
    
    do {
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(books)
        try data.write(to: url)
    } catch {
        print("Error saving books data: \(error)")
        }
}
func loadFromPersistentStore() {
    
        let fileManager = FileManager.default
    
        guard let url = persistentFileURL,
        fileManager.fileExists(atPath: url.path) else { return }
    
    do {
        let data = try Data(contentsOf: url)
        let decodedBooks = PropertyListDecoder()
        books = try decodedBooks.decode([Book].self, from: data)
    } catch {
        print("Error loading books data: \(error)")
        }
    
    }
    
    @discardableResult func Create(titled title: String, withReason reasonToRead: String, hadBeenRead hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        savetoPersistenStore()
        return book
}
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        books.remove(at: index)
        savetoPersistenStore()
        
       
        }
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else {return}
        books[index].hasBeenRead.toggle()
        savetoPersistenStore()
    }
    
    func newBookInfo(fo book: Book, newTitle: String, newReasontoRead: String) {
        guard let index = books.index(of: book) else { return }
        books[index].title = newTitle
        books[index].reasontoRead = newReasontoRead
        savetoPersistenStore()
        }
    
    
    //swift .filter loop over a collection and return an array containing only those elements.
    var readBooks: [Book] {
        let readBooks = books.filter {$0.hasBeenRead == true}
        return readBooks
    }
    var unreadBooks: [Book] {
        let unreadBooks = books.filter {$0.hasBeenRead == false}
        return unreadBooks
    }
    }
        
    


