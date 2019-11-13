//
//  Book.swift
//  Reading List
//
//  Created by Ufuk Türközü on 12.11.19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool? = false
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool? = false) {
        self.hasBeenRead = hasBeenRead ?? false
        self.title = title
        self.reasonToRead = reasonToRead
    }
}
