//
//  Book.swift
//  Reading List
//
//  Created by Rohan Taylor on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book : Equatable, Codable {
    var title : String
    var reasonToRead : Bool
    var hasBeenRead : Bool
    
    init(title : String, reasonToRead : Bool , hasBeenRead : Bool ) {
        self.title = title
        self.hasBeenRead = false
        self.reasonToRead = reasonToRead
    }
}
