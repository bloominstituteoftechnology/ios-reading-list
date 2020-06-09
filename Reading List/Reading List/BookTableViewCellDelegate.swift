//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by James Sedlacek on 6/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}


