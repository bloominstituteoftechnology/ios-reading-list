//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Chad Rutherford on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
