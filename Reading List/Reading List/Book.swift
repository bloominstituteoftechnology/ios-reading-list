//
//  Book.swift
//  Reading List
//
//  Created by Wyatt Harrell on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
