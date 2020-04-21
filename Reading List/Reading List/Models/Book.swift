//
//  Book.swift
//  Reading List
//
//  Created by Kelson Hartle on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool){
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
}
