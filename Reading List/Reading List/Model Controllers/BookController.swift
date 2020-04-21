//
//  BookController.swift
//  Reading List
//
//  Created by Kelson Hartle on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {

    init() {
        loadFromPersistentStore()
    }
    
var books: [Book] = []
    
    func createBook(name:) ->  {
        
    }
    
    


//MARK: - PERSISTENCE

var readingListURL: URL? {
    
    let fileManager = FileManager.default
    let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
    
    let booksURL = documentsDir?.appendingPathComponent("books.plist")
    
    return booksURL
}

func saveToPersistentStore() {
    
    do {
        
        let encoder = PropertyListEncoder()
        
        //Convert the [Book] into a plist
        let booksPlist = try encoder.encode(books)
        
        // Make sure the location we are saving the stars to exists.
        guard let persistentFileUrl = readingListURL else { return }
        
        //Save the plist to the loction we chose
        try booksPlist.write(to: persistentFileUrl)
        
        
    } catch {
        
        print("error saving stars: \(error)")
        
    }
}
    
    func loadFromPersistentStore() {
        guard let persistentFileURL = readingListURL  else { return }
        
        do{
            let decoder = PropertyListDecoder()
            //URL -> Data
            
            //Grab the data (books.plist) from the persistentFileURL
            let booksPlist = try Data(contentsOf: persistentFileURL)
            
            //Data -> [Book] // self is refering to [Book] as a template for the decode.
            let decodedBooks = try decoder.decode([Book].self, from: booksPlist)
            
            self.books = decodedBooks
        
        } catch {
            print("Error loading books from plist \(error)")
        }
        
        
    }
}

