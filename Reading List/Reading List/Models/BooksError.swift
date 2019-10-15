//
//  BooksError.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

enum BooksError: Error {
    case troubleGettingReadingList
    case readingListFileDoesNotExist
    case bookNotInList
    case bookAlreadyInList
    case noBookInTableCell
}
