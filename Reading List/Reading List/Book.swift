//
//  Book.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init (title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
}
