//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jonathan Ferrer on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)

        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Read Books"
        } else if section == 1{
            return "Unread Books"
        } else {
            return nil
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        if section == 0 {
            return  bookController.readBooks.count
        } else{
            return bookController.unreadBooks.count


    }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        guard let bookCell = cell as? BookTableViewCell else { return cell}
        bookCell.delegate = self
        let book = bookFor(indexPath: indexPath)
        bookCell.book = book



        return cell
    }

    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(for: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        } else if segue.identifier == "ShowBook" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.book = bookFor(indexPath: indexPath)
        }
            //destinationVC.book =
        }
    let bookController = BookController()
    }



