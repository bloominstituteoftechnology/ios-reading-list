//
//  Book.swift
//  Reading List
//
//  Created by scott harris on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
        
    }
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.reasonToRead == rhs.reasonToRead && lhs.hasBeenRead == rhs.hasBeenRead
    }
    
}
