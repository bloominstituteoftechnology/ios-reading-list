//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Harm on 3/28/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
