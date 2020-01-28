//
//  BookController.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books = [Book]()
    var readingListURL: URL?{
        
        let fileManager = FileManager.default
        
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil}
        
        let listURL = documentsDir.appendingPathComponent("ReadingLIst.plist")
        
        return listURL
    }
    
}
