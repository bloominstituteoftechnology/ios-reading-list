//
//  Book.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/19/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable, Comparable {
    
//MARK: - Properties
    var title:        String
    var reasonToRead: String
    var hasBeenRead:  Bool
    
//MARK: - Init methods
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
    // Comparable protocol conformance
    static func < (lhs: Book, rhs: Book) -> Bool {
        var bookArray = [lhs.title, rhs.title]
        bookArray.sort()
        return lhs.title == bookArray.first
    }
    
}
