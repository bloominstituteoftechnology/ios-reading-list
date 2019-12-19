//
//  ReadlingListTableViewController.swift
//  Reading List
//
//  Created by Aaron Cleveland on 12/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadlingListTableViewController: UITableViewController {
    
    let bookController = BookController()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.unreadBooks.count
        } else {
            return bookController.readBooks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
           cell.delegate = self
           cell.book = bookController.books[indexPath.row]
           return cell
       }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Books To Read"
        } else {
            return "Books I've Read"
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            return bookController.readBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddBookSegue" {
            if let destination = segue.destination as? BookDetailViewController {
                destination.bookController = bookController
            }
        } else if segue.identifier == "ShowDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            if let destination = segue.destination as? BookDetailViewController {
                destination.book = self.bookFor(indexPath: indexPath)
                destination.bookController = bookController
            }
        }
    }
}

extension ReadlingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: bookController.books[indexPath.row])
        tableView.reloadData()
    }
}
