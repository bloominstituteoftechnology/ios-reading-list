//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookTableViewCellDelegate: AnyObject {
	func toggleHasBeenRead(for cell: BookTableViewCell) 
}
