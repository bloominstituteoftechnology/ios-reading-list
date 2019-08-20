//
//  Book.swift
//  Reading List
//
//  Created by brian vilchez on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    let title:String
    let reasonToRead:String
    var hasBeenRead:Bool
    
    init(title:String,reasonToRead:String) {
        self.title = title
        self.reasonToRead = reasonToRead
        hasBeenRead = false
    }
}
