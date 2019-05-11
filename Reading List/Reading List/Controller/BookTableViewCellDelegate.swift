//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Seschwan on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
