//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Alex Thompson on 10/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol  BookTableViewCellDelegate: class {
    func toggleHasBeenReadFor(cell : BookTableViewCell)
}
