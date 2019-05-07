//
//  BookController.swift
//  Reading List
//
//  Created by Mitchell Budge on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        print("Documents: \(documents.path)")
        return documents.appendingPathComponent("ReadingList.plist")
    }
}
