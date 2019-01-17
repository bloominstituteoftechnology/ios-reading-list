//
//  BookTableViewCellDelegate.swift
//  ReadingListApp
//
//  Created by Nelson Gonzalez on 1/17/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
