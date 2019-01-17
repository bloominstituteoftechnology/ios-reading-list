//
//  Book.swift
//  Reading List
//
//  Created by Angel Buenrostro on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//Book
/*
    Create a "Book.swift" file. Create a struct called Book
    This struct should have the following properties:
    A title String
    A reasonToRead String
    A hasBeenRead Bool
    Create an initializer for the struct so that you can give a default value of false to the hasBeenRead parameter.
    Adopt both the Equatable, and Codable protocols.
*/

import Foundation

struct Book: Codable, Equatable {
    var title : String
    var reasonToRead : String
    var hasBeenRead : Bool
    
    init(title: String, reasonToRead: String,  hasBeenRead: Bool = false) {
        self.hasBeenRead = hasBeenRead
        self.title = title
        self.reasonToRead = reasonToRead
    }
}
