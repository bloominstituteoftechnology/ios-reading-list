//
//  BookController.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookController {
    var books: [Book] = []
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let document = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return document.appendingPathComponent("books.plist")
    }
    
    
    func saveToPersistenceStore() {
        let encoder = PropertyListEncoder()
        do {
            
            //
            
        } catch {
            print(error)
        }
    }
}
