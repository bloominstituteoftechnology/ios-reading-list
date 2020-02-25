//
//  BookController.swift
//  Reading List
//
//  Created by Samuel Esserman on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    var books: [Book] = []
    


    var readingListURL: URL? {
        guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
        return nil
        }
        return docDir.appendingPathComponent("ReadingList.plist")
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
            guard let fileURL = readingListURL else { return }
            let data = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        } catch {
            print(error)
        }
    }
}
