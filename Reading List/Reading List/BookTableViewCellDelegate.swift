//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate : BookTableViewCell {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
