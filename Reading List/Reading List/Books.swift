//
//  Books.swift
//  Reading List
//
//  Created by Cameron Collins on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(hasBeenRead: Bool = false, title: String, reasonToRead: String) {
        self.hasBeenRead = hasBeenRead
        self.reasonToRead = reasonToRead
        self.title = title
    }
}
