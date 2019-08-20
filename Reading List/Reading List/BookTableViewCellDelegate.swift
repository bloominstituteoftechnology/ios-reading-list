//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Donella Barcelo on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
