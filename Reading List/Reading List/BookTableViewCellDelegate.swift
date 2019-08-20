//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Jordan Christensen on 8/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
