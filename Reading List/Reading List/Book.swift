//
//  Book.swift
//  Reading List
//
//  Created by beth on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

// Part 1 - 
struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool

    init(_ title: String, _ reasonToRead: String, _ hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
