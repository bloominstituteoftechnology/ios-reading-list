//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_59 on 1/24/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: class {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
