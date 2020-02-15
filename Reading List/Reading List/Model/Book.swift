//
//  Book.swift
//  Reading List
//
//  Created by Rob Vance on 2/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    // Initalizer for struct with default value of false
    init(title: String, reasonToRead: String, hasBeenRead:Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
