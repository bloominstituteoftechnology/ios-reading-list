//
//  Book.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

struct Book: Codable, Equatable {
    var title: String
    //let author: String // TODO: implement author
    var reasonToRead: String
    var haveRead: Bool
}
