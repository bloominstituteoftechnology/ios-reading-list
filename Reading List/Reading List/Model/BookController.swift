//
//  BookController.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // MARK: - CRUD
    
    // Reading
    private(set) var books:[Book] = []
    
    // creating the file name
    // creating computed property
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("ReadingList.plist")
    }
    
    // CREATE -  new book
            // Question?  Do I need the bool in this function?
    func createBook(withName title:String, reasonToRead:String, hasBeenRead:Bool) {
        let newBook = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(newBook)
        saveToPersistentStore()
    }
    
    // UPDATE - book Title and Reason
    
    func updateBookDetails (book: Book, title: String, reasonToRead: String){
        guard let index = books.index(of: book) else {return}
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
    }
    
    
    // UPDATE - book hasBeenRead
    
    func updateHasBeenRead(book: Book){
        guard let index = books.index(of: book) else {return}
        books[index].hasBeenRead = !book.hasBeenRead
    }
    
    
    // DELETE - book
    func deleteBook(book:Book){
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    
    // MARK: - Persistence Functions
    
    
    // this is where we will save the document
    // will have to use an encoder --> do catch (for errors)
    func saveToPersistentStore(){
        
        // create the url
        guard let url = readingListURL else {return}
        
        do { // create encoder, encode the data, write data to specific file
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch  {
            // store the errors in the users' log
            NSLog("Error saving books to data: \(error)")
        }
    }
    
    
    // this is where we will retrieve the document
    // will have to use a decoder --> do catch (for errors)
    
    func loadFromPersistentStore(){
        
        // create the file manager
        let fm = FileManager.default
        
        // create the url
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else {return}
        
        do {
            // create the decoder
            let decoder = PropertyListDecoder()
            
            // reference the data that was stored above
            let data = try Data(contentsOf: url)
            
            // start to decode
            books = try decoder.decode([Book].self, from: data)
            
        } catch  {
            NSLog("Error loading books data: \(error)")
        }
    }
    
}
