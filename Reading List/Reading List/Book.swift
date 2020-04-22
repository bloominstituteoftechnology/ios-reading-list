//
//  Book.swift
//  Reading List
//
//  Created by Vincent Hoang on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(_ title: String, _ reasonToRead: String, _ hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
