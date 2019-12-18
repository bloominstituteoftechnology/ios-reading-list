//
//  Book.swift
//  Reading List
//
//  Created by Lambda_School_loaner_226 on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

struct Book: Equatable, Codable
{
    var title: String?
    var reasonToRead: String?
    var hasBeenRead: Bool?
    
    init(hasBeenRead: Bool? = false)
    {
        
    }
}
