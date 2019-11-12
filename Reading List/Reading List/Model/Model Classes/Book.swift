//
//  Book.swift
//  Reading List
//
//  Created by Chad Rutherford on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    var name: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Model Initialization
    init(name: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.name = name
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
