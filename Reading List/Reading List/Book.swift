//
//  Book.swift
//  Reading List
//
//  Created by Bradley Yin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    let name: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}
