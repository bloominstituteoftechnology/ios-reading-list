//
//  Book.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/19/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    
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
    
}
