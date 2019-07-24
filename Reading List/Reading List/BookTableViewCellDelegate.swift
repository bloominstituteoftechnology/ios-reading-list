//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Blake Andrew Price on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
