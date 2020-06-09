//
//  BookController.swift
//  Reading List
//
//  Created by James Sedlacek on 6/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter{($0.hasBeenRead)}
    }
    
    var unreadBooks: [Book] {
        return books.filter{(!$0.hasBeenRead)}
    }
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in:.userDomainMask).first else { return nil }
        
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading data: \(error)")
        }
    }
    
    @discardableResult func createBook(title: String, reasonToRead: String) -> Book{
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    func deleteBook(book: Book) {
        var index: Int = 0
        
        for aBook in books {
            if aBook == book {
                books.remove(at: index)
                saveToPersistentStore()
                return
            }
            index += 1
        }
        print("ERROR! Book does not Exist!")
    }

    
    func updateHasBeenRead(for book: Book) {
        var index: Int = 0
        
        for aBook in books {
            if aBook == book {
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
        print("ERROR! Book does not Exist!")
    }
    
    func updateBook(book: Book, newBookTitle: String?, newReasonToRead: String?) {
        var index: Int = 0
        
        for aBook in books {
            if aBook == book {
                if let newTitle = newBookTitle {
                    books[index].title = newTitle
                }
                if let newReason = newReasonToRead {
                    books[index].reasonToRead = newReason
                }
                saveToPersistentStore()
                return
            }
            index += 1
        }
        print("ERROR! Book does not Exist!")
    }
}
