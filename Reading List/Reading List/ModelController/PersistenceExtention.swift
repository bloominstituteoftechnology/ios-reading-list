//
//  PersistenceExtention.swift
//  Reading List
//
//  Created by Lisa Sampson on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

extension BookController {
    
    var readingListURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileName = "Reading List.plist"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func saveToPersistence() {
        let plistEncoder = PropertyListEncoder()
        do {
            //if there is no error, do this
            guard let readingList = readingListURL else { return }
            let booksArray = try plistEncoder.encode(books)
            try booksArray.write(to: readingList)
            
        } catch let error {
            //if there is an error, catch it and do whatever I want in the closure
            //print there was a problem saving your data
            print("Error trying to save data! \(error.localizedDescription)")
        }
    }
    
    func loadFromPersistence() {
        do {
            guard let readingList = readingListURL else { return }
            let booksArray = try Data(contentsOf: readingList)
            let plistDecoder = PropertyListDecoder()
            let decodedBooks = try plistDecoder.decode([Book].self, from: booksArray)
            self.books = decodedBooks
            
        } catch let error {
            print("Error trying to save data! \(error.localizedDescription)")
        }
    }
    
}
