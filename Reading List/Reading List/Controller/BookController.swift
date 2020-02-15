//
//  BookController.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    // MARK: - Computed Properties
    private var persistentFileURL: URL? {
        
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        return books.filter( { $0.hasBeenRead } )
    }
    
    var unreadBooks: [Book] {
        return books.filter( {!$0.hasBeenRead })
    }
    
    
    //MARK: - CRUD
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook (bookToDelete: Book) {
        if let book = books.first(where: {$0.title == bookToDelete.title}) {
           print(book)
            //Needs to delete the book

            if let index = books.firstIndex(of: book) {
                books.remove(at: index)
            }
        } else {
            print("book could not be found")
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        //book.hasBeenRead.toggle()
    }
    
    func updateTitleOrReasonToRead(for book: Book) {
        
    }
    
    
    //MARK: - SAVE and LOAD
    func saveToPersistentStore() {
        
        //place to store the data
        guard let readingListURL = persistentFileURL else { return }
        
        //Need to convert the data to something that can be stored on the phone
        do {
            //Get ready to encode the data
            let encoder = PropertyListEncoder()
            
            //the encoded data
            let booksData = try encoder.encode(books)
            
            //write to the url
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving book data: \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        //Make sure that the file exists at our selected path
        guard let readingListURL = persistentFileURL, fileManager.fileExists(atPath: readingListURL.path) else { return }
        
        do {
            //pull the data from the url
            let booksData = try Data(contentsOf: readingListURL)
            
            //to decode the data
            let decoder = PropertyListDecoder()
            
            // Decode the data and place in array (we specify what type to decode itself into)
            books = try decoder.decode([Book].self, from: booksData)
            
        } catch {
            print("error loading data: \(error)")
        }
    }
}
