//
//  Book.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

import UIKit

struct Book: Codable {
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
//    init (title: String, reasonToRead: String, hasBeenRead: Bool = false) {
//        self.title = title
//        self.reasonToRead = reasonToRead
//        self.hasBeenRead = hasBeenRead
//    }
    mutating func toggleHasBeenRead() {
        self.hasBeenRead = !self.hasBeenRead
    }
}
