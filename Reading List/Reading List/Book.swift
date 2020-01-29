//
//  Book.swift
//  Reading List
//
//  Created by Keri Levesque on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    let title: String
    let reasonToRead: String
    let hasBeenRead: Bool
    
    
    init(_ title: String, _ reasonToRead: String, _ hasBeenRead: Bool = false) {
           self.title = title
           self.reasonToRead = reasonToRead
           self.hasBeenRead = hasBeenRead
       }
    }
 
