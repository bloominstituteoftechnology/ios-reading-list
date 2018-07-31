//
//  Book.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
}
