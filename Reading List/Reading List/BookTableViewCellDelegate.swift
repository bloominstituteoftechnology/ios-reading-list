//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Dillon P on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
