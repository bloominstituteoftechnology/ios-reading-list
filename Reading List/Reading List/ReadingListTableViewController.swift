//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Taylor Lyles on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
	
	func toggleHasBeenRead(for cell: BookTableViewCell) {
		guard let indexPath = tableView.indexPath(for: cell) else { return }
		let book = bookFor(indexPath: indexPath)
		bookController.hasBeenRead(for: book)
		tableView.reloadData()
	}

	let bookController = BookController()

	override func viewDidLoad() {
		super.viewDidLoad()
		
		bookController.loadToPersistentStore()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	private func bookFor(indexPath: IndexPath) -> Book {
		if indexPath.section == 0 {
			return bookController.readBooks[indexPath.row]
		} else {
			return bookController.unReadBooks[indexPath.row]
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
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? BookTableViewCell else { fatalError("Can't reuse") }
		
		cell.delegate = self
		let book = bookFor(indexPath: indexPath)
		cell.book = book
		
		return cell
		
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Read Books"
		} else {
			return "Unread Books"
		}
	}
	
	//MARK: - Navigation
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AddShowSegue" {
			guard let destVC = segue.destination as? BookDetailViewController else { return }
			destVC.bookController = bookController
			destVC.title = "Add new book"
		}
		
		if segue.identifier == "ReadingListShowSegue" {
			guard let destVC = segue.destination as? BookDetailViewController else { return }
			destVC.bookController = bookController
			guard let indexPath = tableView.indexPathForSelectedRow else { return }
			destVC.book = bookFor(indexPath: indexPath )
			
		}
		
	}
	
	
	
}
