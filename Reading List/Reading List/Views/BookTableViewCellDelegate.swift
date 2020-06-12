//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Shawn Gee on 6/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
