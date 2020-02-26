//
//  Book.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import Foundation

struct Book: Codable, Comparable {
    static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.title < rhs.title
    }
    
    var title: String
    var reaasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reaasonToRead = reasonToRead
        hasBeenRead = false
    }
}
