//
//  Book.swift
//  Reading List
//
//  Created by Joshua Rutkowski on 12/5/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

// Book Struct for title, reason to read, and if it has been read. Adopts Equatable and codable.
struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false

}
