//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Osha Washington on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
   func toggleHasBeenRead(for cell: BookTableViewCell)
}

    extension ReadingListTableViewController: BookTableViewCellDelegate {
        func toggleHasBeenRead(for cell: BookTableViewCell) {
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            let book = bookFor(indexPath: indexPath)
            bookController.updateHasBeenRead(for: book)
            tableView.reloadData()
        }
    }
