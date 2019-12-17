//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Tobi Kuyoro on 17/12/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
