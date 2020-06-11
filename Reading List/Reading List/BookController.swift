//
//  BookController.swift
//  Reading List
//
//  Created by Craig Belinfante on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let readingListURL = documentsDirectory?.appendingPathComponent("ReadingListURL.plist")
        return readingListURL
    }
    
    func saveToPersistentStore () {
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: readingListURL!)
        } catch {
            print("Error")
        }
    }
    
    func loadFromPersistentStore () {
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: readingListURL!)
            books = try decoder.decode([Book].self, from: data)
        } catch  {
            print("Error")
        }
    }
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    func deleteBook(book: Book) {
        var index: Int = 0
        
        for myBook in books {
            if myBook == book {
                books.remove(at: index)
                saveToPersistentStore()
                return
            }
            index += 1
        }
        print("Error")
    }
    
    func updateHasBeenRead(book: Book) {
        var index: Int = 0
        
        for myBook in books {
            if myBook == book {
                if books[index].hasBeenRead {
                    books[index].hasBeenRead = false
                } else {
                    books[index].hasBeenRead = true
                }
                saveToPersistentStore()
                return
            }
            index += 1
        }
        print("Error")
    }
    
    func updateBook(book: Book, title: String?, reasonToRead: String?) {
        var index: Int = 0
        
        for myBook in books {
            if myBook == book {
                if let unwrappedTitle = title {
                    books[index].title = unwrappedTitle
                }; if let unwrappedReason = reasonToRead {
                    books[index].reasonToRead = unwrappedReason
                }
                saveToPersistentStore()
                return
            }
            index += 1
        }
        print ("Error")
    }
}
