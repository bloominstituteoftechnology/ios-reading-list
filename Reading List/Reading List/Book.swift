//
//  Book.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable{
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool) {
        self.hasBeenRead = false
        self.title = title
        self.reasonToRead = reasonToRead
        
    }
}
