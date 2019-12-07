//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Joshua Rutkowski on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
