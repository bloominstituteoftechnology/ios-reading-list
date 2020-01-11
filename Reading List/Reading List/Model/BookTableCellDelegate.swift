//
//  BookTableCellDelegate.swift
//  Reading List
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject { //in order to compile with weak var delegate, this must conform to AnyObject
    func toggleHasBeenRead(for cell: BookCell)
}
