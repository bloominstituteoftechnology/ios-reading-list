//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol ReadingListTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell)
}
