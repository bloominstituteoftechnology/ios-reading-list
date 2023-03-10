//
//  BookController.swift
//  Reading List
//
//  Created by Harm on 3/5/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let urlPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let updatedURLPath = urlPath?.appendingPathExtension("ReadingList.plist")
        
        return updatedURLPath
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            
            guard let unwrappedReadingListURL = readingListURL else { fatalError("Unwrapping failed") }
            
            try booksData.write(to: unwrappedReadingListURL)
        } catch {
            print("Error in saveToPersistentStore(): \(error)")
        }
        
    }
    
    
}
