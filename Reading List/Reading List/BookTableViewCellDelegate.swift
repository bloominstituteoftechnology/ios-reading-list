//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by morse on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
