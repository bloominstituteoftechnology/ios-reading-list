//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Dillon P on 8/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    
    var bookController = BookController()
    
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
        var rows: Int = 0
        if section == 0 {
            let readBooksCount = bookController.readBooks.count
            rows = readBooksCount
        } else if section == 1 {
            let unreadBooksCount = bookController.unreadBooks.count
            rows = unreadBooksCount
        }
        
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
        }
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0, bookController.readBooks.count != 0 {
            return "Read Books"
        } else if section == 1, bookController.unreadBooks.count != 0 {
            return "Unread Books"
        } else {
            return nil
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookDetailSegue" {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = bookController
            addBookVC.delegate = self
        } else if segue.identifier == "ShowBookDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow, let detailBookVC = segue.destination as? BookDetailViewController {
                let book = bookFor(indexPath: indexPath)
                detailBookVC.book = book
                detailBookVC.bookController = bookController
                detailBookVC.delegate = self
            }
        }
    }
    
    
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
}


extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
}

extension ReadingListTableViewController: AddBookDelegate {
    func bookWasAdded() {
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
    }
}
