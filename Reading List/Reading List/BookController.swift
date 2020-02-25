//
//  BookController.swift
//  Reading List
//
//  Created by Samuel Esserman on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
}

var readingListURL: URL? {
    guard let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
    return nil
    }
    return docDir.appendingPathComponent("ReadingList.plist")
}
