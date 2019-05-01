//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Michael Redig on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

	let bookController = BookController()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	//MARK: Nav
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let dest = segue.destination as? BookDetailViewController else { return }
		dest.bookController = bookController
		
		if segue.identifier == "EditBook" {
			guard let cell = sender as? BookTableViewCell else { return }
			dest.book = cell.book
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return bookController.readBooks.count
		} else {
			return bookController.unreadBooks.count
		}
    }
	
	func book(for indexPath: IndexPath) -> Book {
		if indexPath.section == 0 {
			return bookController.readBooks[indexPath.row]
		} else {
			return bookController.unreadBooks[indexPath.row]
		}
	}
	
	func indexPath(for book: Book?) -> IndexPath? {
		guard let book = book else { return nil }
		let index: Int?
		let section: Int
		if book.hasBeenRead {
			section = 0
			index = bookController.readBooks.firstIndex(of: book)
		} else {
			section = 1
			index = bookController.unreadBooks.firstIndex(of: book)
		}
		guard let theIndex = index else { return nil }
		return IndexPath(row: theIndex, section: section)
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		guard let bookCell = cell as? BookTableViewCell else { return cell }
		
		bookCell.book = book(for: indexPath)
		bookCell.delegate = self
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			guard let cell = tableView.cellForRow(at: indexPath) as? BookTableViewCell else { return }
			guard let book = cell.book else { return }
			bookController.delete(book: book)
			tableView.deleteRows(at: [indexPath], with: .automatic)
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Read Books"
		} else {
			return "Unread Books"
		}
	}
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
	func toggleHasBeenRead(for cell: BookTableViewCell) {
		if let book = cell.book {
			guard let theIndexPath = tableView.indexPath(for: cell) else { return }
			tableView.beginUpdates()
			tableView.deleteRows(at: [theIndexPath], with: .left)
//			print(theIndexPath)
			let updatedBook = bookController.updateHasBeenRead(for: book)
			guard let newIndexPath = indexPath(for: updatedBook) else { return }
//			print(newIndexPath)
			tableView.insertRows(at: [newIndexPath], with: .left)
			tableView.endUpdates()
//			tableView.reloadSections(IndexSet([0,1]), with: .fade)
//
//			tableView.reloadData()

		}
	}
}
