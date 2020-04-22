//
//  Book.swift
//  Reading List
//
//  Created by Brian Rouse on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
}


