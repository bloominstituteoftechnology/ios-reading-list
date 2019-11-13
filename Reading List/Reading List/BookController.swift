//
//  BookController.swift
//  Reading List
//
//  Created by Sezen Bozdogan on 12.11.19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    private var readingListURL: URL? {
        
        let fileManager = FileManager.default
        
       guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first  else { return nil }
        
        return documentsDir.appendingPathComponent("Reading.plist")
    }
    
    func saveToPersistentStore() {
        
        let fileManager = PropertyListEncoder()
        
        do {
            let bookData = try encoder.encode(books)
            
            guard let fileURL = readingListURL else { return }
            
            try bookData.write(to: fileURL)
            
        } catch {
            print("Error saving stars: \(error)")
        }
        
    }
}
