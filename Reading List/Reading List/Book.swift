//
//  Book.swift
//  Reading List
//
//  Created by Kobe McKee on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


struct Book: Equatable, Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(titled title: String, reasonToRead reason: String, hasBeenRead hasRead: Bool) {
        
        self.title = title
        self.reasonToRead = reason
        self.hasBeenRead = hasRead
        
    }
    
}
