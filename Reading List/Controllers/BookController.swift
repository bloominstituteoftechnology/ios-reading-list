//
//  BookController.swift
//  Reading List
//
//  Created by Bryan Cress on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController {
    // Read
    var books: [Book] = []
    var readbooks: [Book] {
        books.filter{
            $0.hasBeenRead == true }
    }
    var unreadbooks: [Book] {
        books.filter{
            $0.hasBeenRead == false }
    }
    
    // Create
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)

        books.append(book)
        savetoPersistentStore()
    }
    
    //Upload
    
    
    //Delete
    func deleteBook(book: Book) {
        // find book passed in as a parameter in book aray
        guard let index = books.firstIndex(of: book) else { return }
        
        //get books array/remove specific book from books aray
        books.remove(at: index)
    }
    
    
    //Update books object hasBeenRead property
    func updateHasBeenRead(for book: Book) {
        if book.hasBeenRead == true {
            books.append(book)
            guard let index = books.firstIndex(of: book) else { return }
            books.remove(at: index)
            savetoPersistentStore()
        }
    }
    
    //Update edit the books title and/or reasonToRead properties
    func editBook(for book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].title = "\(book.title)"
        books[index].reasonToRead = "\(book.reasonToRead)"
        savetoPersistentStore()
    }
    
    
    
    
    // MARK: - Persistence
    
    var readingListURL: URL? {
        
        //get users document directory
        let fileManger = FileManager.default
        
        // create filename plist
        let documentDir = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        
        
        let booksURL = documentDir?.appendingPathComponent("ReadingList.plist")
        
        // return URL that appends filename string to document directory
        return booksURL
    }
    
    
    //responsible for saving changes to any Book Object
    func savetoPersistentStore() {
        
        do {
            guard let readingListURL = readingListURL else { return }
            
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving books: \(error)")
        }
        
        // responsible for grabbing property list store on device and converting the info back into an array of Book objects
        func loadfromPersistentStore() {
            do {
                guard let readingListURL = readingListURL else { return }
                
                let ReadingPlist = try Data(contentsOf: readingListURL)
                
                let decoder = PropertyListDecoder()
                
                let decodedBooks = try decoder.decode([Book].self, from: ReadingPlist)
                
                self.books = decodedBooks
                
            } catch {
                print("Error loading books from plist: \(error)")
            }
        }
    }
}
