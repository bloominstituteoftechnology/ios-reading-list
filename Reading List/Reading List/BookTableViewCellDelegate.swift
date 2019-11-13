//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Zack Larsen on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation


protocol BookTableViewCellDelegate: class {
    func toglleHassBeenRead(for cell: BookTableViewCell)
}
