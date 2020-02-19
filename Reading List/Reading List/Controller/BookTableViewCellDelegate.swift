//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Jarren Campos on 2/18/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
