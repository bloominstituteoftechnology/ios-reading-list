//
//  Book.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
}
