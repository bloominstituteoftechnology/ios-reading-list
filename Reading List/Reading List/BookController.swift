//
//  BookController.swift
//  Reading List
//
//  Created by admin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
   
    var books = [Book]()
    
    
    
    func saveToPersistenceStore() {
        //let encoder = PropertyListEncoder()
        do {
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            print("Error loading books data: \(error)")
        }
}
    
    func loadFromPersistenStore() {
        do {
            guard let url = readListURL else { return }
            let data = try Data(contentsOf: url)
            let decodeBooks = PropertyListDecoder()
            books = try decodeBooks.decode([Book].self, from: data)
        } catch {
            print("Error loading books data: \(error)")
        }
    }
    
    private var readListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("ReadingList.plist")
    }
}
