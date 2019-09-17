//
//  BookController.swift
//  Reading List
//
//  Created by macbook on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    
    private var books: [Book] = []
    
    var readingListURL: URL? {

        // Get the user's document directory using the FileManager class
        let filemanager = FileManager.default
        
        guard let documents = filemanager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        
        var readBooks: [Book] = books.filter({ $0.hasBeenRead })

        return readBooks
    }
    
    
    // Double check that it's giving you the UNread Books
    var unreadBooks: [Book] {
        
        var unreadBooks: [Book] = books.filter({ !$0.hasBeenRead })
        
        return unreadBooks
    }
    
    
    
    
    
    
    
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        
        return book
    }
    
    
    // TODO - : Itirate through the array an find the correct book to delete
    @discardableResult func deleteBook(book: Book) {
        
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
        
        // books.remove(at: )

    }
    
    
    
    
    // We need to get a book at a particular index. So we’ll need to unwrap the index and then make sure we’re editing a specific book within the books array.
  
   // As of now, book, which is in the initializer for the function is a constant, so we can’t edit that.
    func updateHasBeenRead(for book: Book) {
        
//        guard let index = books.firstIndex(of: book) else { return }
//        
//        
//        for book in books[index] {
//            
//            if book.hasBeenRead == true {
//                book.hasBeenRead = false
//            } else {
//                book.hasBeenRead = true
//            }
//        }
//      
        
    }
    
    
    // TODO: - Edit the Book's title and/or reasonToRead properties.
    func updateTitleAndReasonToRead(for book: Book) {
        
        // code here
        
    }
    
    
    
    
    
    
    
    // Method responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application.
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        // unwrapped version of readingListURL
        guard let url = readingListURL else { return }
        
        do {
            
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
            
        } catch {
            print("Error saving books data \(error)")
        }
    }
    
    
    // Method responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc.
    
    func loadFromPersistentStore() {
        
        do {
            guard let url = readingListURL else { return }
            
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: booksData)
            books = decodeBooks
            
        } catch {
            print("Error loading books data \(error)")
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
