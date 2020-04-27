//
//  Book.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable {
    var name: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(name: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.name = name
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
