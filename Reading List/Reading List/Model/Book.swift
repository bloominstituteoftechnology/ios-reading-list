//
//  Book.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
    
// FIXME: - add static func for comparable protocol
    
}
