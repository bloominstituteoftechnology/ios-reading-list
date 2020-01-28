//
//  Book.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable{
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool
    
    init(title: String, reasonToBeRead: String, hasBeenRead: Bool) {
        self.title = title
        self.reasonToRead = reasonToBeRead
        self.hasBeenRead = false
    }
}
