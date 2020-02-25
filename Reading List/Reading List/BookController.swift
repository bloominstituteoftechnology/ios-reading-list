//
//  BookController.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    var books: [Books] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksUrl = documentsDir?.appendingPathComponent("books.plist")
        
        return booksUrl
    }
}
