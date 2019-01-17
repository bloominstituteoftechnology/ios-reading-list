//
//  Book.swift
//  Reading List
//
//  Created by Moses Robinson on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

struct Book: Equatable, Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        (self.title, self.reasonToRead, self.hasBeenRead) = (title, reasonToRead, hasBeenRead)
    }
}
