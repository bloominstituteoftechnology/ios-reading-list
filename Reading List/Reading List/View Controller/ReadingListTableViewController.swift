//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Percy Ngan on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

	var bookController = BookController()

	override func viewDidLoad() {
		super.viewDidLoad()


	}


	@IBAction func addBook(_ sender: UIBarButtonItem) {

	}
	
	// MARK: - Table view data source



	override func numberOfSections(in tableView: UITableView) -> Int {

		return 2
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return 0
		if section == 0 {
			return bookController.readBooks.count
		} else if section == 1 {
			return bookController.unreadBooks.count
		} else {
			return 0
		}
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Read Books"
		} else if section == 1 {
			return "Unread Books"
		} else {
			return nil
		}
	}


	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

		// Configure the cell...
		guard let bookCell = cell as? BookTableViewCell else { return cell }
		bookCell.delegate = self
		bookCell.book = bookFor(indexPath: indexPath)

		return bookCell
	}

	



	/*
	// Override to support conditional editing of the table view.
	override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the specified item to be editable.
	return true
	}
	*/


	// Override to support editing the table view.
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {

			let book = bookFor(indexPath: indexPath)
			bookController.deleteABook(book: book)
			tableView.deleteRows(at: [indexPath], with: .fade)

		}
	}


	func toggleHasBeenRead(for cell: BookTableViewCell) {
		guard let indexPath = tableView.indexPath(for: cell) else { return }
		let book = bookFor(indexPath: indexPath)
		bookController.updateHasBeenRead(for: book)
		tableView.reloadData()
	}


	private func bookFor(indexPath: IndexPath) -> Book {
		if indexPath.section == 0 {
			return bookController.readBooks[indexPath.row]
		} else {
			return bookController.unreadBooks[indexPath.row]
		}
	}
	/*
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

	}
	*/

	/*
	// Override to support conditional rearranging of the table view.
	override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
	// Return false if you do not want the item to be re-orderable.
	return true
	}
	*/

	/*
	// MARK: - Navigation

	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/

}
