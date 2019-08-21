//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Ciara Beitel on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
