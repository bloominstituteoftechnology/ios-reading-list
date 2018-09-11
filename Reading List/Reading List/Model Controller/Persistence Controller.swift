//
//  Persistence Controller.swift
//  Reading List
//
//  Created by Iyin Raphael on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

extension BookController{
    
    func saveToPersistence(){
        guard let url = readingListURL else {return}
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(books)
            try data.write(to: url)
        }catch{
            NSLog("An error occured when trying to save to Persistence: \(error)")
        }
    }
    
    func loadToPersistence(){
        let fm = FileManager.default
        guard let url = readingListURL, fm.fileExists(atPath: url.path) else {return}
        do{
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedBooks = try decoder.decode([Book].self, from: data)
            books = decodedBooks
        }catch{
            NSLog("Error loading books: \(error)")
        }
    }
    
    var readingListURL: URL? {
        let fm = FileManager.default
        guard let documentsDir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentsDir.appendingPathComponent("ReadingList.plist")
    }
     
}
