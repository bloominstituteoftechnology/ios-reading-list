//
//  Persistence Controller.swift
//  Reading List
//
//  Created by Iyin Raphael on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

extension BookController{
    
    
    //URL to the bank/phone
    var readingListURL : URL?{
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let fileName = "ReadingList(Persistence).plist"
        return documentsDirectory.appendingPathComponent(fileName)
        
    }
    
    
    
    //Encodable is when you give the system data to translate
    //SaveToPersistence
    func saveToPersistence(){
        let plistEncoder = PropertyListEncoder()
        do {
            guard let readingList = readingListURL else {return}
            let booksData = try plistEncoder.encode(books)
            try booksData.write(to: readingList)
            //if there is no erro, do this
        }catch let error {
            //if there is an error, catch it and do what ever I want in this closure
            //print there was a problem saving your data
            print("Error trying to save data! \(error.localizedDescription)")
        }
    }
    
    //decodable is when you get the translated data from the system
    func loadFromPersistence() {
        do {
            guard let readingList = readingListURL else {return}
            let booksData = try Data(contentsOf: readingList)
            let plistDecoder = PropertyListDecoder()
            let decodedBooks = try plistDecoder.decode([Book].self, from: booksData)
            self.books = decodedBooks
        } catch let error{
            //print there was a problem saving your data
            print("Error trying to save data! \(error.localizedDescription)")
        }
    }
}
