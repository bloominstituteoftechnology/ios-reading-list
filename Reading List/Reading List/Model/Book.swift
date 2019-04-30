//
//  Book.swift
//  Reading List
//
//  Created by Sameera Roussi on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(name: String, reasonToRead: String, hasBeenRead: Bool) {
        self.title = name
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
}
