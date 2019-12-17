//
//  Book.swift
//  Reading List
//
//  Created by Tobi Kuyoro on 17/12/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    var hasBeenRead: Bool = false
}
