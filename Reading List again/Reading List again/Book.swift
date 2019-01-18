//
//  Book.swift
//  Reading List again
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Nathanael Youngren. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var isRead: Bool
    
    init(title: String, reasonToRead: String, isRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.isRead = isRead
    }
}
