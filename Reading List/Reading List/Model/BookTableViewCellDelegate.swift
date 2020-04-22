//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Marissa Gonzales on 4/22/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
