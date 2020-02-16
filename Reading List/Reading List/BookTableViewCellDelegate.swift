//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
