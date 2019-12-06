//
//  Book.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasontoRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool) {
        self.title = title
        self.reasontoRead = reasonToRead
        self.hasBeenRead = false
    }
}
