//
//  Book.swift
//  Reading List
//
//  Created by Gi Pyo Kim on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        hasBeenRead = false
    }
}
