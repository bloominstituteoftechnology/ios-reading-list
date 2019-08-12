//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Eoin Lavery on 11/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
