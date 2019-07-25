//
//  ReadingListVC.swift
//  Reading List
//
//  Created by Ry Bautista on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	let bookController = BookController()
	
	override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
		tableView.delegate = self
    }
	
    // MARK: - Navigation
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let manageBookVC = segue.destination as? ManageBookVC {
			manageBookVC.delegate = self
			if let indexPath = tableView.indexPathForSelectedRow {
				manageBookVC.book = bookController.filteredBooks[indexPath.section].books[indexPath.row]
			}
		}
    }

}

extension ReadingListVC: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return bookController.filteredBooks.count
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return bookController.filteredBooks[section].category
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return bookController.filteredBooks[section].books.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else { return UITableViewCell() }
		let books = bookController.filteredBooks[indexPath.section].books
		let book = books[indexPath.row]
		
		cell.delegate = self
		cell.book = book
		return cell
	}
}

extension ReadingListVC: ManageBookVCDelegate {
	
	func passBookDetails(existingBookIndex index: Int?, title: String, reasonRead reason: String) {
		if let index = index {
			bookController.updateBook(at: index, title: title, reason: reason)
		} else {
			bookController.createBook(title: title, reason: reason)
		}
		tableView.reloadData()
		navigationController?.popViewController(animated: true)
	}
}

extension ReadingListVC: BookCellDelegate {
	func toggleReadStatus(for book: Book) {
		bookController.toggleReadStatus(for: book)
		tableView.reloadData()
	}
	
}
