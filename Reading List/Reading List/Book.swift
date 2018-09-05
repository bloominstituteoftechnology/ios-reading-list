//
//  Book.swift
//  Reading List
//
//  Created by Farhan on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

class Book: Equatable, Codable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        if (lhs.title == rhs.title && lhs.reasonToRead == rhs.reasonToRead && lhs.hasBeenRead == rhs.hasBeenRead) {
            return true
        } else {
            return false
        }
    }
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
