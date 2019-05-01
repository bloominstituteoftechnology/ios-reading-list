//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		for b in bookController.books {
			print(b)
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		
    }
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		
		if section == 0 {
			
			return bookController.readBooks.count == 0 ? "" : "read books"
		}
		if section == 1 {
			return bookController.unreadBooks.count == 0 ? "" : "unread books"
		}
		return nil
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return booksFor(section: section).count
    }
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let book = booksFor(section: indexPath.section)[indexPath.row]
			bookController.deleteBook(book: book)
		}
		tableView.reloadData()
	}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

		guard let bookCell = cell as? BookTableViewCell else { return cell }
		bookCell.delegate = self
		bookCell.book = booksFor(section: indexPath.section)[indexPath.row]
		
		return bookCell
	}

	let bookController = BookController()
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
	func toggleHasBeenRead(for cell: BookTableViewCell) {
		guard let book = cell.book else { return }
		bookController.updateHasBeenRead(for: book)
		tableView.reloadData()
	}
	
	func booksFor(section: Int) -> [Book] {
		if section == 0 {
			return bookController.readBooks
		} else if section == 1 {
			return bookController.unreadBooks
		}
		return []
	}
	
}
