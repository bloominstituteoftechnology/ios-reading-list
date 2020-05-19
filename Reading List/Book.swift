//
//  Book.swift
//  Reading List
//
//  Created by Mike Nichols on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    var hasBeenRead: Bool = false
}
