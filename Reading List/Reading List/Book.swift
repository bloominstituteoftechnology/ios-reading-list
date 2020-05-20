//
//  Book.swift
//  Raindow
//
//  Created by Drew Miller on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}
