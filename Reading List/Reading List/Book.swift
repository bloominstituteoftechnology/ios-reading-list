//
//  Book.swift
//  Reading List
//
//  Created by Bradley Yin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    
    var name: String
    var reasonToRead: String
    var hasBeenRead: Bool 
    init(name:String, reasonToRead: String) {
        self.name = name
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
}
