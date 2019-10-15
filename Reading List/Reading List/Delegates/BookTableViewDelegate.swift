//
//  BookTableViewDelegate.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
