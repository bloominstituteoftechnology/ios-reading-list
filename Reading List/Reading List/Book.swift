//
//  Book.swift
//  Reading List
//
//  Created by Enrique Gongora on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(hasBeenRead: Bool = false, reasonToRead: String, title: String) {
        self.hasBeenRead = hasBeenRead
        self.reasonToRead = reasonToRead
        self.title = title
    }
}
