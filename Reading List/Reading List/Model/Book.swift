//
//  Book.swift
//  Reading List
//
//  Created by Ian French on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation



// create struct
struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    
// add initializer with Bool = false
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
    self.title = title
    self.reasonToRead = reasonToRead
    self.hasBeenRead = hasBeenRead
    }

}
