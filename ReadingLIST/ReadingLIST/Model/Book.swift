//
//  Book.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import Foundation
struct Book : Equatable,Codable {
    let title: String
    let reasonToRead: String
    var hasBeenRead = false
    static let segueId = "BookSegue"
    static let cellId = "BookCell"
    static let addSegue = "AddSegue"
}
