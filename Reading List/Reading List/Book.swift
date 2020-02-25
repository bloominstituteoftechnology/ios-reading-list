//
//  Book.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title t: String,
         reasonToRead r: String,
         hasBeenRead h: Bool = false) {
        title = t
        reasonToRead = r
        hasBeenRead = h
    }
}
