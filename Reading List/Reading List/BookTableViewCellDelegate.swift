//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_201 on 10/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

func toggleHasBeenRead(for cell: BookTableViewCell) {
    BookController.updatehasBeenRead()
    tableView.reload()
}
