//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Nonye on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
//MARK: PART 3 #4
protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
