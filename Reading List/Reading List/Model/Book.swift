//
//  Book.swift
//  Reading List
//
//  Created by Ilgar Ilyasov on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    
    // MARK: - Properties
    
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    // MARK: - Initializer
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = hasBeenRead
    }
}
