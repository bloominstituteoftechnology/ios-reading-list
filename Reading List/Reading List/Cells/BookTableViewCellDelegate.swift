//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Donella Barcelo on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
