//
//  Book.swift
//  
//
//  Created by Ian Becker on 5/19/20.
//

import Foundation

struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
