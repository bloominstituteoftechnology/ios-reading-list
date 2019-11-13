//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Ufuk Türközü on 13.11.19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
