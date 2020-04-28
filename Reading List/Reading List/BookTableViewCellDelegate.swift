//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Ian French on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
