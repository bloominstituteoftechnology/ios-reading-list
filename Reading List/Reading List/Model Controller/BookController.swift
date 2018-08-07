//
//  BookController.swift
//  Reading List
//
//  Created by Iyin Raphael on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController{
    //instantiate array of books
    var books: [Book] = []
    
    
    //create
    func create(title: String, reasonToRead: String){
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
    }
    
    //update
    func updateTitleandRead(book: Book, title: String, reasonToRead: String){
        guard let index = books.index(of: book) else {return}
        var scratch = book
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(scratch, at: index)
        saveToPersistence()
    }
    
    func updateHasBeenRead(book:Book){
        guard let index = books.index(of: book) else {return}
        var scratch = book
        scratch.hasBeenRead = !book.hasBeenRead
        books.remove(at: index)
        books.insert(scratch, at: index)
        saveToPersistence()
    }
    
    //delete
    
    func delete(book: Book){
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistence()
    }
    
    
    //for read section
    var readBooks: [Book]{
        return books.filter({$0.hasBeenRead})
    }
    
    //for unread section of books
    var unreadBooks: [Book]{
        return books.filter({$0.hasBeenRead == false})
    }
}
