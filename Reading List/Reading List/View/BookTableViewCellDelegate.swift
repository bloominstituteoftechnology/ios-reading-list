//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Harmony Radley on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
