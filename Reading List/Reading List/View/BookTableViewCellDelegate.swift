//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Harmony Radley on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenReadFor(cell: BookTableViewCell)
}
