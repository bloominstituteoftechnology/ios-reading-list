//
//  Book.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
  
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        hasBeenRead = false
    }
    
}

