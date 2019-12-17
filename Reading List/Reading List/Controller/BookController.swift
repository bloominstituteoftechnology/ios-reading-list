//
//  BookController.swift
//  Reading List
//
//  Created by Tobi Kuyoro on 17/12/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var book: [Book] = []
    
    var readlistURL: URL? {
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let booksURL = documentsDir.appendingPathComponent("ReadingList.plist")
        
        return booksURL
    }
}
