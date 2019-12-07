//
//  Book.swift
//  Reading List
//
//  Created by Joshua Rutkowski on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


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
