//
//  BookController.swift
//  Reading List
//
//  Created by LambdaSchoolVM_Catalina on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    private(set) var books: [Book] = []
    
    // step 7 and 8 not sure
    //    private(set) var readBooks: [Book]
        //    private(set) var unreadBooks: [Book]

    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        return documents.appendingPathComponent("ReadingList.plist")
    }

//create
    @discardableResult func createBook(title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
      let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        books.append(book)
        saveToPersistentStore()
        return book
    }
    
    
    
    // save and Load
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error saving Books Data:\(error)")
        }
    }
    
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let bookData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: bookData )
        } catch {
            print("Error Loading Books Data: \(error)")
        }
    }

}
