//
//  BookController.swift
//  Reading List
//
//  Created by beth on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

//BootController Step-

//Book array
class BookController {
    
    var books: [Book] = [] {
    didSet {
            books.sort { $0.title < $1.title }
        }
    }
    
    /// Returns books that have been read
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true }
        return readBooks
    }
    /// Returns book objects that have not been read
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false }
        return unreadBooks
    }

      init() {
         loadFromPersistentStore()
     }
    
    // methods -
    
    @discardableResult func createBook(named title: String, withReason reason: String) -> Book {
       let book = Book(title, reason)
        books.append(book)
        print("\(unreadBooks)")
        saveToPersistentStore()
        return book
        }
    
       func deleteBook(named book: Book) {
             guard let index = books.firstIndex(of: book) else { return }
             books.remove(at: index)
             saveToPersistentStore()
         }

        func editBook(book: Book, title: String, reasonToRead: String) {
             guard let index = books.firstIndex(of: book) else { return }
              books[index].title = title
              books[index].reasonToRead = reasonToRead
              saveToPersistentStore()
          }

         func updateHasBeenRead(for book: Book) {
             guard let index = books.firstIndex(of: book) else { return }
             books[index].hasBeenRead.toggle()
             saveToPersistentStore()
         }

         func updateReasonOrTitle(for book: Book) {
             guard let index = books.firstIndex(of: book) else { return }
             books[index].title = book.title
             books[index].reasonToRead = book.reasonToRead
             saveToPersistentStore()
         }

    
//Step 3
private var readingListURL: URL? {
    let fileManager = FileManager.default
    
    guard let documentsDir =
        fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
       let filename = "ReadingList.plist"
    return documentsDir.appendingPathComponent(filename)
}
    
     //Step 4 - This function will be responsible for saving any changes to any Book object so that the changes will still be there when the user comes back into the application. You can implement this by doing the following
private func saveToPersistentStore() {
    guard let url = readingListURL else { return }
    
    do {
        let encoder = PropertyListEncoder()
        let booksData = try encoder.encode(books)
        try booksData.write(to: url)
    } catch {
        print("Error saving books data: \(error)")
    }
  }

// step 5 - This function will be responsible for grabbing the property list stored on the device, and converting the information in it back into an array of Book objects so the application may display them on the table view, etc

private func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }

        do {
            let booksData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            books = decodedBooks
        } catch {
            print("Error loading books data: \(error)")
        }
    }
}
