//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Taylor Lyles on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
	
	let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return bookController.readBooks.count
		} else {
			return bookController.unReadBooks.count
		}
    }
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let book = bookController.books[indexPath.row]
			bookController.delete(book: book)
			// Delete the row from the data source
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	

	
	
}
