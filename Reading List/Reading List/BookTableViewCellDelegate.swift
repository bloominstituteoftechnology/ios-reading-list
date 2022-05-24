//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/23/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
