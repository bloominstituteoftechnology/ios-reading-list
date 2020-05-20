//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Richard Gibbs on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation


protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell) 
}
