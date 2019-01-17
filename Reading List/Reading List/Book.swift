//
//  Book.swift
//  Reading List
//
//  Created by Cameron Dunn on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book : Equatable, Codable{
    var title: String?
    var reasonToRead: String?
    var hasBeenRead: Bool
    init(){
        hasBeenRead = false
    }
}
