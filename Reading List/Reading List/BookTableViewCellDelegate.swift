//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Aaron Peterson on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
