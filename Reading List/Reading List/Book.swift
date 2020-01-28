//
//  Book.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable{
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
    init(title: String, reasonToBeRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToBeRead
    }
}
