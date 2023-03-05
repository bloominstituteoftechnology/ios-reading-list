//
//  Book.swift
//  Reading List
//
//  Created by Harm on 3/5/23.
//  Copyright © 2023 Lambda School. All rights reserved.
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
}
