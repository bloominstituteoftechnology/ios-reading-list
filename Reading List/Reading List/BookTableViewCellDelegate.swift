//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Taylor Lyles on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
	func toggleHasBeenRead(for cell: BookTableViewCell)
}

