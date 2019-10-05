//
//  Book.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
//MARK: Step 1-4
    //this structure creates a Book, which is codable and equatable. it has a title, a reason to read, and a hasBeenRead property which is a bool.
    //It also has an init that gives us a default value of FALSE fo our hasBeenRead Bool. 
struct Book: Codable, Equatable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
  
    
    init(title: String, reasonToRead: String) {
        self.title = title
        self.reasonToRead = reasonToRead
        hasBeenRead = false
    }
    
}

