//
//  BookController.swift
//  Reading List
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
class BookController {
    var books = [Book]()
    
    var readBooks: [Book] {
        return books.filter {$0.hasBeenRead == true}
    }
    
    var unreadBooks: [Book] {
        return books.filter {$0.hasBeenRead == false}
    }
    
    var readingList: URL? {
        let fileManager = FileManager.default
       
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        //append books.plist to documentDirectory to create file at path (URL)
        let booksUrl = documentDirectory.appendingPathComponent("books.plist")
        return booksUrl
    }
    
    //MARK: Create
    @discardableResult func addBookToRead(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        self.books.append(book)
        saveToPersistentStore()
        return book
    }
    
    //MARK: Read
    func loadFromPersistentStore() {
        guard let fileURL = readingList else {return}
        
        do {//step 2 of do/try/catch
            let booksData = try Data(contentsOf: fileURL) //step 1 of do/try/catch
            let decoder = PropertyListDecoder()
            let booksArray = try decoder.decode([Book].self, from: booksData)
            self.books = booksArray
        } catch {
            //step 3 of do/try/catch
            print("Error loading books from plist: \(error)")
        }
        
    }
    
    //MARK: Update
    func updateHasBeenRead(for book: Book) {
        for (index, thisBook) in books.enumerated() where thisBook.title == book.title {
            books[index].hasBeenRead = !books[index].hasBeenRead
        }
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, title: String = "", reasonToRead: String = "" ) {
        for (index, thisBook) in books.enumerated() where thisBook.title == book.title {
            if title != "" {
                books[index].title = title
                print(books[index].title)
            }
            if reasonToRead != "" {
                books[index].reasonToRead = reasonToRead
            }
        }
        saveToPersistentStore()
    }
      
    
    //MARK: Delete
    func removeBookFromList(book: Book) {
        //Add a "Delete" method that passes in a Book object as a parameter, and removes it from the books array
        self.books.removeAll { (book) -> Bool in
            return true
        }
        saveToPersistentStore()
    }
    
    //MARK: Helper Methods
    func saveToPersistentStore() {
        //check to make sure file url exists
        guard let fileURL = readingList else { return }
        do {
            let encoder = PropertyListEncoder()
            //use PList encoder to write books file
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: fileURL)
        } catch {
            print("Error Saving books: \(error)")
        }
    }
    
    //MARK: **DANGER** Dev/Testing
    func testSave() {
        books = [Book(title: "Hello World", reasonToRead: "Learn to Code")] //DANGER overwrites book array
        saveToPersistentStore() //DANGER saves overwrite
    }
    
    func testDelete() {
        guard let book = books.first else {print("no books"); return}
        removeBookFromList(book: book) //DANGER deletes first book from array
    }
    
    func testHasBeenRead() {
        //testSave() //DANGER overwrites book array
        print("hasBeenRead was: \(books[0].hasBeenRead)")
        updateHasBeenRead(for: books[0])
        print("is now: \(books[0].hasBeenRead)")
    }
    
    func testUpdateBook() {
        testSave()
        guard let book = books.first else {print("no books"); return}
        updateBook(book: book, title: "New Title", reasonToRead: "Don't really have one anymore")
    }
    
    func testReadList() {
        testUpdateBook()
        testHasBeenRead()
        print("Books Read: \(readBooks)")
    }
    
}
