//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Casualty on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    var rating: Int
    
    init(title: String, reasonToRead: String, rating: Int) {
        self.title = title
        self.reasonToRead = reasonToRead
        hasBeenRead = false
        self.rating = rating
    }
}

// Sorting alphabetically
extension Book: Comparable {
    static func < (a: Book, z: Book) -> Bool {
        return a.title.lowercased() < z.title.lowercased()
    }
}
