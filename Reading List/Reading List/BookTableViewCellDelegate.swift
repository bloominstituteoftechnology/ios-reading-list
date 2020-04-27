//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
