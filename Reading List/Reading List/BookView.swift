//
//  BookView.swift
//  Reading List
//
//  Created by William Bundy on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import Foundation
import UIKit

protocol BookCellDelegate: class
{
	func onToggle(_ book:Book, state:Bool)
}

class BookCell: UITableViewCell
{
	weak var delegate:BookCellDelegate!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var readSwitch: UISwitch!
	var book:Book! {
		didSet {
			nameLabel.text = book.name
			readSwitch.setOn(book.read, animated: true)
		}
	}

	@IBAction func readToggled(_ sender: Any)
	{
		delegate?.onToggle(book, state:readSwitch.isOn)
	}
	// TODO(will) handle switch-flipping with a delegate
}

class BookListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, BookCellDelegate
{
	var controller:BookController = BookController()

	@IBOutlet weak var table: UITableView!

	func onToggle(_ book: Book, state: Bool)
	{
		controller.markRead(book, state:state)
	}

	override func viewDidLoad() {
		table.dataSource = self
		table.delegate = self
	}

	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)

		controller.sortBooks()
		table.reloadData()
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		print(section)
		if section == 0 {
			return controller.unreadBooks.count
		} else if section == 1 {
			return controller.readBooks.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		let defaultCell = tableView.dequeueReusableCell(withIdentifier: "BookCell")
		guard let cell = defaultCell as? BookCell else { return defaultCell!}
		cell.delegate = self
		if indexPath.section == 0 {
			cell.book = controller.unreadBooks[indexPath.row]
		} else if indexPath.section == 1{
			cell.book = controller.readBooks[indexPath.row]
		}
		return cell
	}

	func numberOfSections(in tableView: UITableView) -> Int
	{
		return 2
	}

	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
	{
		return ["Unread", "Read"][section]
	}

	override  func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if let dest = segue.destination as? AddBookVC {
			dest.controller = controller
			if let sender = sender as? BookCell {
				dest.book = sender.book
			}
		}
	}
	
}

class AddBookVC: UIViewController
{
	var controller:BookController!
	var book:Book?

	@IBOutlet weak var nameField: UITextField!
	@IBOutlet weak var reasonField: UITextField!

	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)

		guard let book = book else { return }
		nameField.text = book.name
		reasonField.text = book.readingReason
	}


	@IBAction func addBook(_ sender: Any)
	{
		guard let name = nameField.text, name != "",
			let reason = reasonField.text, reason != ""
			else {return}

		if var book = book {
			controller.delete(book)
			book.name = name
			book.readingReason = reason
			controller.add(book)
		} else {
			controller.create(name, reason)
		}
		navigationController?.popViewController(animated: true)
	}
}
