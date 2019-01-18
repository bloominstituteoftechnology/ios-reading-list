//
//  BookTableViewCellDelegate.swift
//  ReadingList
//
//  Created by Jocelyn Stuart on 1/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
