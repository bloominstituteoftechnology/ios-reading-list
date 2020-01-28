//
//  BookController.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books = [Book]()
    var readingListURL: URL?{
        
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let listURL = documentsDir.appendingPathComponent("ReadingLIst.plist")
        
        return listURL
    }
    
    func saveToPersistentStore(){
        
        guard let readingListURL = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        do{
            let booksData = try encoder.encode(books)
            try booksData.write(to: readingListURL)
            
            
        } catch {
            print("Error encoding books array: \(error)")
        }
    }
    
    func loadFromPersistnetStore (){
        
        guard let readingListURL = readingListURL else { return }
        
        do{
            let decoder = PropertyListDecoder()
            
            let readingListData = try Data(contentsOf: readingListURL)
            
            let readingListArray = try decoder.decode([Book].self, from: readingListData)
        } catch{
            print("Error decoding readList: \(error)")
        }
    }
    
    func createListEntry (with title: String, reasonToRead: String){
        
        let book = Book(title: title, reasonToBeRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        saveToPersistentStore()
        
    }
    
    func deleteListEntry (book: Book){
        
 // 6 second item.  Need to delete an element at the book's index path but index path isn't available
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books.remove(at: bookIndex)
        saveToPersistentStore()
        
    }
    
    func updateHasBeenRead(for book: Book){
        
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        saveToPersistentStore()
    }
    
    func editBookInformation(for book: Book){
        
        guard let bookIndex = books.firstIndex(of: book) else { return }
        books[bookIndex].title = books[bookIndex].title
        books[bookIndex].reasonToRead = books[bookIndex].reasonToRead
        saveToPersistentStore()
    }
    
    var readBooks: [Book]{
        var readBooks = [Book]()
        
        for book in books{
            if book.hasBeenRead == true{
                readBooks.append(book)
            }
        }
        return readBooks
    }
    
    var unreadBooks: [Book]{
          var unreadBooks = [Book]()
          
          for book in books{
              if book.hasBeenRead == false{
                  unreadBooks.append(book)
              }
          }
          return unreadBooks
      }
    
    
}
