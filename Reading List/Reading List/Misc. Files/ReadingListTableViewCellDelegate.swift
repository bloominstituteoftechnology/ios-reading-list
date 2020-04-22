//
//  ReadingListTableViewCellDelegate.swift
//  Reading List
//
//  Created by Brian Rouse on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
protocol ReadingListTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell)
}
