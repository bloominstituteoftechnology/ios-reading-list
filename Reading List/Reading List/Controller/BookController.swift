//
//  BookController.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    // Computed Property
    private var persistentFileURL: URL? {
        
        //It only has once place to store so we grab an instance of it
        let fileManager = FileManager.default
        
        //navigate to the location where the documenns are stored
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        //Creating a file
        return documents.appendingPathComponent("ReadingList.plist")
    }
    
    func saveToPersistentStore() {
        
        //place to store the data
        guard let readingListURL = persistentFileURL else { return }
        
        //Need to convert the data to something that can be stored on the phone
        do {
            //Get ready to encode the data
            let encoder = PropertyListEncoder()
            
            //the encoded data
            let booksData = try encoder.encode(books)
            
            //write to the url
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving book data: \(error)")
        }
        
    }
    
    func loadFromPersistentStore() {
        
        let fileManager = FileManager.default
        //Make sure that the file exists at our selected path
        guard let readingListURL = persistentFileURL, fileManager.fileExists(atPath: readingListURL.path) else { return }
        
        do {
            //pull the data from the url
            let booksData = try Data(contentsOf: readingListURL)
            
            //to decode the data
            let decoder = PropertyListDecoder()
            
            // Decode the data and place in array (we specify what type to decode itself into)
            books = try decoder.decode([Book].self, from: booksData)
            
        } catch {
            print("error loading data: \(error)")
        }
    }
}
