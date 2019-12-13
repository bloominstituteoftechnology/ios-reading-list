//
//  Book.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

import UIKit



class Book: Codable, Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        return lhs.title == rhs.title
    }
    
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool = false
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
    
    func toggleHasBeenRead() {
        self.hasBeenRead = !self.hasBeenRead
    }
}
