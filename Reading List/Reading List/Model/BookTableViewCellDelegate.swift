//
//  BookTableViewCellDelegatge.swift
//  Reading List
//
//  Created by Clayton Watkins on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
