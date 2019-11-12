//
//  BookController.swift
//  Reading List
//
//  Created by Zack Larsen on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
//    init() {
//        loadFromPersistentStore()
//    }
}
private var readingListURL: URL? {
    let fileManager = FileManager.default
    
    guard let documentsDir = fileManager.urls( for: .documentDirectory, in: .userDomainMask).first else {
        return nil }
    
    return documentsDir.appendingPathComponent("ReadingList.plist")
    
}

func saveToPersistentStore() {
    
    let encoder = PropertyListEncoder()
    
    do {
        let booksDate = try encoder.encode(books)
    }
}
