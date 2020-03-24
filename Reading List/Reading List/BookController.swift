//
//  BookController.swift
//  Reading List
//
//  Created by ronald huston jr on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    //  CRUD
    //  read - the value of the books
    var books: [Book] = []
    
    //  "viewDidLoad" of the BookController 
    init() {
        loadFromPersistentStore()
    }
    
    var readBooks: [Book] = []
    
    var unreadBooks: [Book] = []
    
    
    //  create a book
    //  you should use model controller to initialize a book
    func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        saveToPersistentStore() 
    }
    
    func deleteBook(title: Book) {
        _ = title
        books.remove(at: 1)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        let book = Book(title: <#T##String#>, reasonToRead: <#T##String#>, hasBeenRead: Bool)
        book.hasBeenread.toggle()
    }
    
    //  MARK: - persistence -
    
    // where are we going to save and load our books from?
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        // grab the app's documents directory - User/Documents
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        //  create a unique location for the books property list (plist) - User/Documents/books.plist
        let booksURL = documentsDir?.appendingPathComponent("books.plist")
        return booksURL
    }
    
    //  save the books array to the readingListURL
    func saveToPersistentStore() {
        
        do {
            //  create the encoder
            let encoder = PropertyListEncoder()
            
            //  convert the stars into a plist
            let booksData = try encoder.encode(books)
            
            //  grab the unwrapped location of the URL property 
            guard let persistentFileURL = readingListURL else { return }
            
            //  save the file to the documents directory
            try booksData.write(to: persistentFileURL)
            
        } catch let saveError {
            //  handle the error that gets "thrown" here
            //  this catch statement will only run if a throwing method fails
            print("error saving starts: \(saveError)")
        }
    }
    
    func loadFromPersistentStore() {
        //  this function is responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects.
        
        guard let readingListURL = readingListURL else { return }
        
        do {
            
            //  create the decoder
            let decoder = PropertyListDecoder()
            
            //  access the data (plist) form of the books
            let booksPlist = try Data(contentsOf: readingListURL)
            
            //  Plist -> [Book]
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            
            self.books = decodedBooks
            
        } catch {
            print("error decoding books: \(error)")
        }
    }
}
