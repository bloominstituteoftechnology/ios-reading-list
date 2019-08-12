//
//  Book.swift
//  Reading List
//
//  Created by Vici Shaweddy on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

struct Book: Codable, Equatable {
    var name: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
}
