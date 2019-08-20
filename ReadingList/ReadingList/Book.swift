//
//  Book.swift
//  ReadingList
//
//  Created by Joshua Franklin on 8/20/19.
//  Copyright © 2019 AMSU. All rights reserved.
//

import Foundation

struct Book: Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead = false
    
   
}
