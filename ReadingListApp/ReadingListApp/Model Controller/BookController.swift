//
//  BookController.swift
//  ReadingListApp
//
//  Created by Nelson Gonzalez on 1/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

class BookController {
    init(){
        loadFromPersistentStore()
    }
    private(set) var books: [Book] = []
    
    private var readingListURL: URL? {
        //Get the user's document directory using the FileManager class
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
       // Create a filename string for the plist, such as "ReadingList.plist"
        let finalLocation = documentsDirectory.appendingPathComponent("booklist.plist")
        //Return a url that appends the filename string to the document directory. In doing this, you will create a full path wherein the Books in plist form will be stored on the user's device.
        return finalLocation
    }
    
    func saveToPersistentStore(){
        guard let url = readingListURL else {return}
        //Create an instance of PropertyListEncoder.
        let propertyListEncoder = PropertyListEncoder()
//        Inside of a do-try-catch block create a constant called booksData. Using the encode(value: ...) function of the property list encoder, encode the books array into Data.
        
        do {
            let booksData = try propertyListEncoder.encode(books)
            //Call the write(to: URL) function on the data you encoded computed property. The url you pass in should be an unwrapped version of the readingListURL property.
            try booksData.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStore() {
       // Inside of a do-try-catch- block, unwrap the readingListURL property.
        guard let readingListUrl = readingListURL, FileManager.default.fileExists(atPath: readingListUrl.path) else { return }
        do {
            //Still inside of the block, use the Data(contentsOf: URL) initializer to get access to the property list form of the books. Assign this data you initialize to a constant.
            let data = try Data(contentsOf: readingListUrl)
            //Initialize a PropertyListDecoder and assign it to a constant.
            let decoder = PropertyListDecoder()
            //Create a constant called decodedBooks. Set its value by calling the decode method on the property list decoder you just created, and passing in the type it should be decoded as, and the data constant you made a couple steps ago. (Hint: the type parameter to this function should be [Book].self)
            let decodedBooks = try decoder.decode([Book].self, from: data)
            //Set the value of the books property in the BookController to the decodedBooks you just made.
            books = decodedBooks
           
        } catch {
            //In the catch block, you should make an error message that is descriptive of what happened
            print(error.localizedDescription)
        }
    }
    
    func create(withBook title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func delete(book: Book) {
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book: Book) {
        guard let index = books.index(of: book) else {return}
        //turn it from a constant to a variable
        var book = books[index]
        book.hasBeenRead = !book.hasBeenRead
        //swap it.
        books.remove(at: index)
        books.insert(book, at: index)
        saveToPersistentStore()
    }
    
    func updateBook(for book: Book, with title: String, reasonToRead: String) {
        guard let index = books.index(of: book) else {return}
        var book = books[index]
        book.title = title
        book.reasonToRead = reasonToRead
        books.remove(at: index)
        books.insert(book, at: index)
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter( { $0.hasBeenRead == false })
    }
}
