//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Isaac Lyons on 9/17/19.
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
    
    func bookFor(indexPath: IndexPath) -> Book {
        return bookController.books[indexPath.row]
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number: Int
        if section == 0 {
            number = bookController.readBooks.count
        } else {
            number = bookController.unreadBooks.count
        }
        return number
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            cell.book = bookController.readBooks[indexPath.row]
        } else {
            cell.book = bookController.unreadBooks[indexPath.row]
        }

        cell.delegate = self
        
        return cell
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
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            bookController.delete(book: bookFor(indexPath: indexPath))
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title: String
        if section == 0 {
            title = "Read books"
        } else {
            title = "Unread books"
        }
        return title
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookDetailVC = segue.destination as? BookDetailViewController {
            if segue.identifier == "AddBookShowSegue" {
                bookDetailVC.bookController = bookController
                bookDetailVC.delegate = self
            } else if segue.identifier == "EditBookShowSegue",
                let indexPath = tableView.indexPathForSelectedRow {
                bookDetailVC.book = bookFor(indexPath: indexPath)
                bookDetailVC.bookController = bookController
                bookDetailVC.delegate = self
            }
        }
    }

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        // The readme says to get the IndexPath for the cell, then get the book based on that index path, but this should be a much simpler solution
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
}

extension ReadingListTableViewController: BookDetailDelegate {
    func bookWasSaved() {
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
    }
}
