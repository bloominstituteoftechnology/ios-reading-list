//
//  Book.swift
//  Reading List
//
//  Created by admin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable,Equatable {
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool = false
}
