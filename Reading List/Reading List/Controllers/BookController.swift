//
//  BookController.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController: Codable {
    var books: [Book] = []
    
    var readingListURL: URL? {
        get {
//            guard FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: .none, create: false) is String else {return nil}
            
            let fileManager = FileManager.default
            guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            let plistFile = documentsDir.appendingPathComponent("ReadingList.plist")
            
            return plistFile
        } }
}
