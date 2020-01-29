//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Enrique Gongora on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
