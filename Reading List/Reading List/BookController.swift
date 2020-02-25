//
//  BookController.swift
//  Reading List
//
//  Created by Nichole Davidson on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentsDir?.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
           // Convert Stars into a Property List
           
           let encoder = PropertyListEncoder()
           
           do {
           
               let booksData = try encoder.encode(books)
               
               guard let starsURL = persistentFileURL else { return }
               
              try starsPlist.write(to: starsURL)
               
           } catch {
               // The catch statement gets called if the function(s) that you call "try" on fails.
               print("Unable to save stars to plist: \(error)")
               
           }
           
       }
}
