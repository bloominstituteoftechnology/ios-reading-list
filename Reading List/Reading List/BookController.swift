//
//  BookController.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksUrl = documentsDir?.appendingPathComponent("books.plist")
        
        return booksUrl
    }
    
    func saveToPersistentStore() {
        // Convert our book Property List
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books) //FIXME: 
            
            guard let booksUrl = readingListURL else { return }
            
            try booksData.write(to: booksUrl)
            
        } catch {
            print("Unable to save books to plist: \(error)")
        }
    }
}
