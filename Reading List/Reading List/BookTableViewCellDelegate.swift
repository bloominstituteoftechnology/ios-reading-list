//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
	func toggleHasBeenRead(for cell: BookTableViewCell)
}
