//
//  Book.swift
//  Reading List
//
//  Created by David Wright on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable {
    let title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}

extension Book: Equatable {
    static func ==(lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
}
