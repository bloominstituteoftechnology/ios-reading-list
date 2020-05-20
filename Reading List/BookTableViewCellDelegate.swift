//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Bryan Cress on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation
protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCellDelegate?)
    
}
