//
//  BookController.swift
//  Reading List
//
//  Created by Lisa Sampson on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - Properties
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead})
    }
    
    var unreadBooks: [Book] {
        return books.filter({$0.hasBeenRead == false})
    }
    
    // MARK: - CRUD
    func create(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        
        books.append(book)
    }
    
    func updateBookTitleandReason(book: Book, title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else { return }
        
        var scratch = book
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.insert(scratch, at: index)
        
        saveToPersistence()
    }
    
    func updateHasBeenRead(book: Book) {
        guard let index = books.index(of: book) else { return }
        
        var scratch = book
        scratch.hasBeenRead = !book.hasBeenRead
        
        books.remove(at: index)
        books.insert(scratch, at: index)
        
        saveToPersistence()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else { return }
        
        books.remove(at: index)
        
        saveToPersistence()
    }
}
