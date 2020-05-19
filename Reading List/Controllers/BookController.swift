//
//  BookController.swift
//  Reading List
//
//  Created by Bryan Cress on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


class BookController: Codable {
    var books: [Book]
    
    
    
    
    
    
    // MARK: - Persistence
    var readingListURL: URL? {
        
    //get users document directory
        let fileManger = FileManager.default
        
         // create filename plist
        let documentDir = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first
        
    
        let booksURL = documentDir?.appendingPathComponent("ReadingList.plist")
        
        // return URL that appends filename string to document directory
        return booksURL
    }
    
    
    //responsible for saving changes to any Book Object
    func savetoPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving books: \(error)")
        }
    
        // responsible for grabbing property list store on device and converting the info back into an array of Book objects
        func loadfromPersistentStore() {
            do {
                guard let readingListURL = readingListURL else { return }
                
                let ReadingPlist = try Data(contentsOf: readingListURL)
                
                let decoder = PropertyListDecoder()
                
                let decodedBooks = try decoder.decode([Book].self, from: ReadingPlist)
                
                self.books = decodedBooks
                
            } catch {
                print("Error loading books from plist: \(error)")
            }
        }
    }
}
