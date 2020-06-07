//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Norlan Tibanear on 6/7/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell) 
}
