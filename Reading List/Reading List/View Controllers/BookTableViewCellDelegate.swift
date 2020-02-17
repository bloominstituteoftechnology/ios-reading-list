//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Chad Parker on 2020-02-16.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
