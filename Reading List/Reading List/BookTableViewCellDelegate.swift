//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by David Williams on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
