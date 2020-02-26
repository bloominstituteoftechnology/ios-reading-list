//
//  Book.swift
//  Reading List
//
//  Created by Lydia Zhang on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
struct Book: Codable {
    var title: String
    var reason: String
    var hasBeenRead: Bool = false
}
extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title && lhs.reason == rhs.reason && lhs.hasBeenRead == rhs.hasBeenRead
    }
}

