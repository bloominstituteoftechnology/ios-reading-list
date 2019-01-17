//
//  Book.swift
//  ReadingList
//
//  Created by Jocelyn Stuart on 1/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
    
    
}
