//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jordan Christensen on 8/21/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch (section) {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        var book: Book?
        switch (indexPath.section) {
        case 0:
            book = bookController.readBooks[indexPath.row]
        case 1:
            book = bookController.unreadBooks[indexPath.row]
        default:
            return UITableViewCell()
        }
        cell.delegate = self
        cell.book = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "\(bookController.readBooks.count) books read"
        case 1:
            return "\(bookController.unreadBooks.count) books to read"
        default:
            return ""
        }
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            switch (indexPath.section) {
            case 0:
                bookController.updateHasBeenRead(for: bookController.readBooks[indexPath.row])
            case 1:
                bookController.updateHasBeenRead(for: bookController.unreadBooks[indexPath.row])
            default:
                break
            }
        }
    }
}
