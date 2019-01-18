//
//  BookTableViewCellDelegate.swift
//  ReadTheList Project
//
//  Created by Michael Flowers on 1/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
