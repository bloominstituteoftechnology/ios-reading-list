//
//  BookController.swift
//  Reading List
//
//  Created by Cameron Dunn on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books : [Book] = []
    var readBooks : [Book]{
        let booksThatHaveBeenRead = books.filter{$0.hasBeenRead == true}
        return booksThatHaveBeenRead
    }
    var unreadBooks : [Book]{
        let booksThatHaventBeenRead = books.filter{$0.hasBeenRead == false}
        return booksThatHaventBeenRead
    }
    var readingListURL : URL?{
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalLocation = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return finalLocation
    }
    func create(title: String, reasonToRead reason: String){
        var book = Book()
        book.reasonToRead = reason
        book.title = title
        books.append(book)
        saveToPersistentStore()
    }
    func delete(bookToDelete book: Book){
        let index = books.index(of: book)
        books.remove(at: index!)
    }
    func updateHasBeenRead(for book: Book){
        let index = books.index(of: book)
        var newBook : Book = book
        newBook.hasBeenRead = !book.hasBeenRead
        books[index!] = newBook
        saveToPersistentStore()
    }
    func updateBookProperties(for book: Book, newTitle: String, newReasonToRead: String){
        let index = books.index(of: book)
        var newBook : Book = book
        newBook.reasonToRead = newReasonToRead
        newBook.title = newTitle
        books[index!] = newBook
        saveToPersistentStore()
    }
    func saveToPersistentStore(){
        let propertyListEncoder = PropertyListEncoder()
        do{
            let booksData = try propertyListEncoder.encode(books)
            try booksData.write(to: readingListURL!)
        }catch{
            print(error)
        }
    }
    
    func loadFromPersistentStore(){
        do{
            guard let url : URL = readingListURL else {return}
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        }catch{
            print(error)
        }
    }
}
