//
//  Book.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
struct Book : Equatable,Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead = false
    
}
