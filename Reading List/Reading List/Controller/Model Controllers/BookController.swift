//
//  BookController.swift
//  Reading List
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
class BookController {
    var books = [Book]()

    var readingList: URL? {
        let fileManager = FileManager.default
       
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        //append books.plist to documentDirectory to create file at path (URL)
        let booksUrl = documentDirectory.appendingPathComponent("books.plist")
        return booksUrl
    }
    
    //MARK: Update
      func saveToPersistentStore() {
        /*
        Create an instance of PropertyListEncoder.
        Inside of a do-try-catch block create a constant called booksData. Using the encode(value: ...) function of the property list encoder, encode the books array into Data.
        Call the write(to: URL) function on the data you encoded computed property. The url you pass in should be an unwrapped version of the readingListURL property.
        */
        
        
        //check to make sure file url exists
        guard let fileURL = readingList else { return }
        do {
            let encoder = PropertyListEncoder()
            //use PList encoder to write books file
            let booksData = try encoder.encode(books)
            
            try booksData.write(to: fileURL)
        } catch {
            print("Error Saving books: \(error)")
        }
    }
    //MARK: Read
    func loadFromPersistentStore() {
        guard let fileURL = readingList else {return}
        
        do {//step 2 of do/try/catch
            let booksData = try Data(contentsOf: fileURL) //step 1 of do/try/catch
            let decoder = PropertyListDecoder()
            let booksArray = try decoder.decode([Book].self, from: booksData)
            self.books = booksArray
        } catch {
            //step 3 of do/try/catch
            print("Error loading books from plist: \(error)")
        }
        
    }
    
    //MARK: Dev/Testing
    func testSave() {
        books = [Book(title: "Hello World", reasonToRead: "Learn to Code")]
        saveToPersistentStore()
    }
    
}
