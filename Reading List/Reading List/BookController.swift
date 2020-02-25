//
//  BookController.swift
//  Reading List
//
//  Created by Samuel Esserman on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    


    var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    
    let listURL = documentsDir.appendingPathComponent("ReadingList.plist")
    
    return listURL
        
        
    }

    func saveToPersistentStore() {
        guard let fileURL = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let bookData = try encoder.encode(books)
            
            try bookData.write(to: fileURL)
            
        } catch {
            print(error)
            }
    }
        
    func loadFromPersistentStore() {
        do{
            if let fileURL = readingListURL {
            let data = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - Step 6
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deletedBook(book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func updateHasBeenRead(for book: Book) {
        if let index = books.firstIndex(of: book) {
            books[index].hasBeenRead.toggle()
            saveToPersistentStore()
        }
    }
    
    func update(book: Book, with title: String, and reasonToRead: String?) {
        if let index = books.firstIndex(of: book) {
            var book = books[index]
            book.title = title
            if let reasonToRead = reasonToRead {
                book.reasonToRead = reasonToRead
            }
            saveToPersistentStore()
        }
    }
    
}
