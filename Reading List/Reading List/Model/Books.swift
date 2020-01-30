//
//  Books.swift
//  Reading List
//
//  Created by Malik Barnes on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

// MARK: - Model
struct Book: Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
