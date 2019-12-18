//
//  BookController.swift
//  Reading List
//
//  Created by Lambda_School_loaner_226 on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookController
{
    var books: [Book] = []
    
    @discardableResult func createBook()
    {
      
        
        
        
        
      saveToPersistent()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var readingListURL: URL?
    {
        let fileManager = FileManager.default
        guard let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileName = "readinglist.plist"
        return documentDir.appendingPathComponent(fileName)
    }
    
    func saveToPersistent()
    {
        guard let fileURL = readingListURL else {return}
        do
        {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: fileURL)
        }
        catch
        {
            print("Error encoding book data: \(error)")
        }
        
    }
    
    func loadFromPersistentStore()
    {
        do
        {
        guard let fileURL = readingListURL else {return}
            let booksData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            self.books = try decoder.decode([Book].self, from:booksData)
        }
        catch
        {
            print("Error decoding book data: \(error)")
        }
    }
}
