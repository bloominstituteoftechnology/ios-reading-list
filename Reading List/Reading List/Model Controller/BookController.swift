//
//  BookController.swift
//  Reading List
//
//  Created by John McCants on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookController {
    var books : [Book] = []
    
    var readingListURL : URL? {
        let fm = FileManager.default
               guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
               return dir.appendingPathComponent("ReadingList.plist")
    }
    
    init() {
        loadFromPersistentStore()
    }
    
    //MARK: -Persistence
       
       
       func saveToPersistentStore() {
           guard let url = readingListURL else {
               return
           }
           
           do {
               
               let encoder = PropertyListEncoder()
               let data = try encoder.encode(books)
               try data.write(to: url)
               
           } catch {
               fatalError("Was not able to encode data")
           }
           
       }
       
       private func loadFromPersistentStore() {
           let fm = FileManager.default
           guard let readingURL = readingListURL, fm.fileExists(atPath: readingURL.path) else { return
       }
           
           do {
               let data = try Data(contentsOf: readingURL)
               let decoder = PropertyListDecoder()
               books = try decoder.decode([Book].self, from: data)
               print(readingURL)
               
               
               
           } catch {
               fatalError("No data was saved")
               
           }
           
       }
    func updateHasBeenRead(for book: Book) {
           
           guard let bookIndex = books.firstIndex(of: book) else { return }
           books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
           saveToPersistentStore()
           
       }
    
    func createBook(title: String, reasonToRead: String) {
          
          let book = Book(title: title, reasonToRead: reasonToRead)
          books.append(book)
          saveToPersistentStore()
      }
    
    func updateBookData(for book: Book, title: String, reasonToRead: String) {
        guard let bookIndex = books.firstIndex(of: book) else { return }
        
        var temp = book
        temp.title = title
        temp.reasonToRead = reasonToRead
        
        books.remove(at: bookIndex)
        books.insert(temp, at: bookIndex)
        
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
       
}
