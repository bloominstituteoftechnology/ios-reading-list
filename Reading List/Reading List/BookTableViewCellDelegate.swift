//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by patelpra on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
