//
//  BookController.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    var readingListURL: URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let listURL = documentsDirectory.appendingPathComponent("ReadingList.plist")
        return listURL
    }
    
    init() {
        // FIXME: - what goes here?
    }
    
    // MARK: - SAVE
    
    
}
