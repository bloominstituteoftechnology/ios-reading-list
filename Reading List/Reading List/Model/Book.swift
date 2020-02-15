//
//  Book.swift
//  Reading List
//
//  Created by Elizabeth Thomas on 2/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    static let shared = Book()
    private init() {}
    
    var title: String = ""
    var reasonToRead: String = ""
    var hasBeenRead: Bool = false
}
