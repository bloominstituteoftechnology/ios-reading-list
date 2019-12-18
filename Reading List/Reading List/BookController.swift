//
//  BookController.swift
//  Reading List
//
//  Created by Rohan Taylor on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


class BookController : Codable {

var books : [Book] = []

var readingListURL: URL? {
    
     let fileManager = FileManager.default
     
     guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
     
     let readingListURL = documentsDir.appendingPathComponent("ReadingList.plist")
     
     return readingListURL
     
 }

func saveToPersistentStore() {
      //make sure fileURL exists, otherwise we can save the stars there.
      guard let fileURL = readingListURL else { return }
      
      do {
          
          let encoder = PropertyListEncoder()
          
          let booksData = try encoder.encode(books)
          
          try booksData.write(to: fileURL)
      } catch {
          print("Error saving stars: \(error)")
          
      }
  }

func loadFromPersistentStore() {
      
      guard let fileURL = readingListURL else { return }
      
      do {
      
      let booksData = try Data(contentsOf: fileURL)
      let decoder = PropertyListDecoder()
      let booksArray = try decoder.decode([Book].self, from: booksData)
          
          self.books = booksArray
          
      } catch {
          print("Error loading stars from plsit: \(error)")
          
      }
  }
    
    func create(title : String, reasonToRead : Bool , hasBeenRead : Bool){
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    func delete(book : Book) {
        guard let bookIndex = books.firstIndex(of: book)  else { return }
        books.remove(at: bookIndex)
        }
    func updatehasBeenRead(for book : Book) {
          guard let bookIndex = books.firstIndex(of: book)  else { return }
        books[bookIndex].hasBeenRead = !books[bookIndex].hasBeenRead
        saveToPersistentStore()
    }
    func updateReasonToRead(book : Book , title : String, reasonToRead : Bool , hasBeenRead : Bool){
        guard let bookToUpdate = books.firstIndex(of: book) else { return }
        var tempBook = book
        
        tempBook.title = title
        tempBook.reasonToRead = reasonToRead
        
        books.remove(at: bookToUpdate)
        
        books.insert(tempBook, at: bookToUpdate)
        }
    var readBooks: [Book] {
        return books.filter({$0.hasBeenRead == true})
    }
      var unreadBooks: [Book] {
          return books.filter({$0.hasBeenRead == false})
        }
        
}

