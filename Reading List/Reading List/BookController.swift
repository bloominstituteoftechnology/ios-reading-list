//
//  BookController.swift
//  Reading List
//
//  Created by Vijay Das on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    private(set) var books: [Book] = []
    
    
    

    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let finalLocation = documentsDirectory.appendingPathComponent("ReadingList.plist")
        
        return finalLocation
    }
    
    func saveToPersistentStore() {
        
        guard let url = readingListURL else { return }
        
        let encoder = PropertyListEncoder()
        
        do {
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        
        guard let url = readingListURL, FileManager.default.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            books = try decoder.decode([Book].self, from: data)
            
        } catch {
            print(error)
        }
        
  
    }
    

}
    
    
  
    
    

