//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Shawn James on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    // MARK: - Properties
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
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 { return bookController.readBooks.count }
        if section == 1 { return bookController.unreadBooks.count }
        else { return 0 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        // Configure the cell...
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 { return "Read Books" }
        if section == 1 { return "Unread Books" }
        else { return "Error" }
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
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailSegue" {
            if let destinationVC = segue.destination as? BookDetailViewController {
                destinationVC.bookController = bookController
            }
        }
        
        if segue.identifier == "addSegue" {
            if let destinationVC = segue.destination as? BookDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let book = bookFor(indexPath: indexPath)
                    destinationVC.bookController = bookController
                    destinationVC.book = book
                }
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
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let book = bookFor(indexPath: indexPath)
            bookController.updateHasBeenRead(for: book)
            tableView.reloadData()
        }
    }
    
}
