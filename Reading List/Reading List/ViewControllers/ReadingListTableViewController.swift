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
	
	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		
		if section == 1 {
			return "unread books"
		}
		return "read books"
	}
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//pick correct section
		if section == 2 {
			return bookController.unreadBooks.count
		}
		return bookController.readBooks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
		guard let bookCell = cell as? BookTableViewCell else { return cell }
		
		if indexPath.section == 2 {
			bookCell.book = BookController().unreadBooks[indexPath.row]
		} else {
			bookCell.book = BookController().readBooks[indexPath.row]
		}
		
		bookCell.delegate = self
		
		return bookCell
    }

	
	let bookController = BookController()
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
	func toggleHasBeenRead(for cell: BookTableViewCell) {
		guard let book = cell.book else { return }
		print("delegate2")
		bookController.updateHasBeenRead(for: book)
		tableView.reloadData()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showBookCell" {
			guard let vc = segue.destination as? BookDetailViewController else { return }
		}
	}
	
}
