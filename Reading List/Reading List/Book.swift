//
//  Book.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    
    // MARK: - Properties
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    var imageData: Data?
    
    // MARK: - Initializers
    init (title: String, reasonToRead: String, imageData: Data?) {
        self.title = title
        self.reasonToRead = reasonToRead
        self.hasBeenRead = false
        self.imageData = imageData
    }
}
