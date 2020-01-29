//
//  ookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Lambda_School_Losaner_256 on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasBeenRead(ofr cell: BookTableViewCell)
}
