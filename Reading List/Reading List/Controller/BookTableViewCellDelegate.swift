//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Shawn James on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
