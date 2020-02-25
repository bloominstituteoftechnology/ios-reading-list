//
//  BookController.swift
//  Reading List
//
//  Created by Bhawnish Kumar on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    // var books: [Book] = [] -> Trouble here
    
    func createBook(title: String, reasonToRead: String) {
        let book = Book(title: title, reasonToRead: reasonToRead)
        // books.append(book)
    }
    var readingListURL: URL? {
        let fileMananger = FileManager.default
        
        let documentsDir = fileMananger.urls(for: .documentDirectory, in: .userDomainMask)
        
        let booksURL = documentsDir.appendPathComponent("Reading.Plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let bookData = try encoder.encode(books)
            
            guard let booksURL = 
        } catch {
            
        }
    }
}
