//
//  BookController.swift
//  Reading List
//
//  Created by Enrique Gongora on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    var readBooks: [Book]{
        return books.filter ({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book]{
         return books.filter ({ $0.hasBeenRead == false })
    }
    
    func createBook(title: String, reasonToRead: String){
        let book = Book(reasonToRead: reasonToRead, title: title)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(with book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    var readingListURL: URL?{
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let booksURL = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return booksURL
    }
    
    
    func saveToPersistentStore() {
        guard let fileURL = readingListURL else { return }
        do{
        let encoder = PropertyListEncoder()
        let booksData = try encoder.encode(books)
            try booksData.write(to: fileURL)
        }catch{
            print("Error encoding books array: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        guard let fileURL = readingListURL else { return }
        do{
            let decoder = PropertyListDecoder()
            let booksData = try Data(contentsOf: fileURL)
            let booksArray = try decoder.decode([Book].self, from: booksData)
            self.books = booksArray
        }catch{
            print("Error decoding books: \(error)")
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let updateRead = books.firstIndex(of: book) else {return}
        books[updateRead].hasBeenRead.toggle()
        saveToPersistentStore()
        
    }
    
    func titleAndReasonToRead(for book: Book){
        guard let titleOrReason = books.firstIndex(of: book) else {return}
        books[titleOrReason].title = book.title
        books[titleOrReason].reasonToRead = book.reasonToRead
        saveToPersistentStore()
    }
    
    func editBook(book: Book, title: String) {
        guard let bookToEdit = books.firstIndex(of: book) else { return }
        var tempBook = book
        tempBook.title = book.title
        books.remove(at: bookToEdit)
        books.insert(tempBook, at: bookToEdit)
        saveToPersistentStore()
    }
    
}
