//
//  Book.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

//create model and conform to protocols to allow persistence of data
struct Book: Codable, Equatable {
    //properites
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
    
    
}
