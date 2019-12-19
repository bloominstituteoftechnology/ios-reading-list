//
//  BookTableViewDelegate.swift
//  Reading List
//
//  Created by Aaron Cleveland on 12/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
