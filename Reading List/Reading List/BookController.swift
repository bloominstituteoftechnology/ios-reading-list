//
//  BookController.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    //Created an array of books for the BookController to hold onto.
    private(set) var books: [Book] = []
    //creating a fileURL to be able to set a destination on the file manager. There could possibly be no destination so this value is optional and unwrapped.
    //Creating a file path for the data that conforms to Codable (arrays) to be saved to the users home directory (.userDomainMask).
    //returned the URL with the plist file path, creating the full path to the user home directory.
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    //
    @discardableResult func createBook(named title: String, withReasonToRead reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    //this is a computed property that filters out books that have been read. hasbeenread is set to false in the Book initilizer. So this is inversing the operation
    var readBooks: [Book] {
            let booksReadArray = books.filter {!$0.hasBeenRead}
            return booksReadArray
    }
    //this is the same just not checking for the inverse property. so it is filtering out all the books in the array that have have NOT been read due to hasbeenread being defaulted to FALSE
    var unreadBooks: [Book] {
        let bookUnreadArray = books.filter {$0.hasBeenRead}
        return bookUnreadArray
    }
    
    //this creates a placeholder for the first spot and deletes whatever is at the first spot
    func deleteBook(book: Book){
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(book: Book){
        guard let i = books.firstIndex(of: book) else { return }
        books[i].hasBeenRead.toggle()
        saveToPersistentStore()
    }
    
     @discardableResult func updateBook(for book: Book, newTitle: String, newReason: String) -> Book?{
        guard let i = books.firstIndex(of: book) else {return createBook(named: book.title, withReasonToRead: book.reasonToRead)}
        books[i].title = newTitle
        books[i].reasonToRead = newReason
        saveToPersistentStore()
        return books[i]
    }
    
    //if the url is valid, create an encoder that can encode the data using codable that specializes in property listing. encode our array of books to our persistent file URL
    //then attempt to write the data to a specified destination, which is unwrapped to make sure we have a value in the beginning of the function, and if so to write the data. If not catch it, and throw the error to the console.
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        }
        catch {
            print("Error saving the books data: \(error)")
        }
    }
    //to get our data back out, first we unwrap the file manager. Then we unwrap the url of the data, by using .fileExists, if it works, we assign out data property to the contents of the URL, we assign our decoder to the same as our encoder, and assign our books array to the data within the home directory file path we saved it to. else we throw another error.
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {return}
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        }
        catch {
            print("Error loading book data: \(error)")
        }
    }
    
}
