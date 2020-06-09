//
//  Book.swift
//  Reading List
//
//  Created by B$hady on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool) {
    self.title = title
    self.reasonToRead = reasonToRead
    self.hasBeenRead = hasBeenRead
    }
}
