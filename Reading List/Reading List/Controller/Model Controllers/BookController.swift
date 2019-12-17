//
//  BookController.swift
//  Reading List
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

var books = [Book]()

var readingList: URL? {
    let fileManager = FileManager.default
   
    guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
    //append books.plist to documentDirectory to create file at path (URL)
    let booksUrl = documentDirectory.appendingPathComponent("books.plist")
    return booksUrl
}
