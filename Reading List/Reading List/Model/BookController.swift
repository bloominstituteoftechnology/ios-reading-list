//
//  BookController.swift
//  Reading List
//
//  Created by Welinkton on 9/12/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    // CRUD
    // Reading
    private(set) var books:[String] = []
    
    //creatiing the file name
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let directory = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return directory.appendingPathComponent("ReadingList.plist")
    }
    
}
