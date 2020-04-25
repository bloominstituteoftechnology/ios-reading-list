//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Rob Vance on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
