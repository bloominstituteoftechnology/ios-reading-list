//
//  BookController.swift
//  Reading List
//
//  Created by Samuel Esserman on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    


    var readingListURL: URL? {
    let fileManager = FileManager.default
    guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
    
    let listURL = documentsDir.appendingPathComponent("ReadingList.plist")
    
    return listURL
    }

    func saveToPersistentStore() {
        guard let fileURL = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let bookData = try encoder.encode(books)
            
            try bookData.write(to: fileURL)
            
        } catch {
            print(error)
            }
    }
        
    func loadFromPersistentStore() {
        do{
            if let fileURL = readingListURL {
            let data = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
            }
        } catch {
            print(error)
        }
    }
}
