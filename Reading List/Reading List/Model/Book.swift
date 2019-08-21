//
//  Book.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
    mutating func toggleHasBeenRead () {
        self.hasBeenRead = !self.hasBeenRead
    }
}
