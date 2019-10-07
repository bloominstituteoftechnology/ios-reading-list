//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Christy Hicks on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
