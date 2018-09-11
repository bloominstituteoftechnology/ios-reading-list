//
//  BookController.swift
//  Reading List
//
//  Created by Iyin Raphael on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
   
    func createBook(title: String, reasonToRead: String){
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistence()
    }
    
    func updateBook(book: Book, title: String, reasonToRead: String){
        guard let index = books.index(of: book) else {return}
        var scratch = book
        scratch.reasonToRead = reasonToRead
        scratch.title = title
        books.remove(at: index)
        books.insert(scratch, at: index)
        saveToPersistence()
    }
    
    func updateHasBeenRead(for book: Book) -> Bool{
       return book.hasBeenRead != book.hasBeenRead
    }
    
    var books: [Book] = []
     
}
