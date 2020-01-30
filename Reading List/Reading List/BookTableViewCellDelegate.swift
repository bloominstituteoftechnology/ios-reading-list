//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by scott harris on 1/29/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
