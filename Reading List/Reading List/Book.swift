//
//  Book.swift
//  Reading List
//
//  Created by Jonalynn Masters on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}

