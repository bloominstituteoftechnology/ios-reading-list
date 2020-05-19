//
//  Book.swift
//  Reading List
//
//  Created by Bryan Cress on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}
