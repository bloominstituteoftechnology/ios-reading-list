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
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		//pick correct section
		
		return bookController.books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
		guard let bookCell = cell as? BookTableViewCell else { return cell }
		let book = bookController.books[indexPath.row]
		bookCell.delegate = self
		bookCell.book = book 
		return bookCell
    }

	var bookController = BookController()
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
	func toggleHasBeenRead(for cell: BookTableViewCell) {
		guard let book = cell.book else { return }
		print("delegate2")
		bookController.updateHasBeenRead(for: book)
		tableView.reloadData()
	}
	
	
}
