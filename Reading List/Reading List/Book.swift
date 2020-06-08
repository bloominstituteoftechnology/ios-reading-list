//
//  Book.swift
//  Reading List
//
//  Created by Gladymir Philippe on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.reasonToRead && lhs.hasBeenRead == rhs.hasBeenRead
    }
}
