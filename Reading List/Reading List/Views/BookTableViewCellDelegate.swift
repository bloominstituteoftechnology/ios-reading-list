//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Cora Jacobson on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
