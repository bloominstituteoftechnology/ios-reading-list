//
//  Book.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
import UIKit

struct Book : Codable,Equatable,Comparable {
    static func < (lhs: Book, rhs: Book) -> Bool {
        return lhs.title < rhs.title
    }
    
    var title: String
    var reasonToRead: String
    var hasBeenRead = false
    var image : String
}
