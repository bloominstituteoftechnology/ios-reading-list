//
//  Book.swift
//  Reading List
//
//  Created by brian vilchez on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Equatable,Codable {
    let title:String
    let reasonToRead:String
    var hasbeenRead:Bool = false
}
