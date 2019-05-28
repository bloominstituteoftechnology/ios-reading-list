//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Mitchell Budge on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
