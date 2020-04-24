//
//  Book.swift
//  Reading List
//
//  Created by Aaron Peterson on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}
