//
//  Book.swift
//  Reading List
//
//  Created by Bobby Keffury on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
    }
}









