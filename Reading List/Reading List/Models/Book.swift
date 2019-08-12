//
//  Book.swift
//  Reading List
//
//  Created by Eoin Lavery on 10/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
    }
}
