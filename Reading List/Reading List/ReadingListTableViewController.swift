//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Mark Gerrior on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    var bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Delegate
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        // FIXME: Find cell and toggle value.
        // HINT: Think about how to get an IndexPath using the cell parameter of the toggleHasBeenRead(for cell: ...). Once you have an IndexPath, you can get an instance of Book to pass into the update function.
        print(cell)
        
        //reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The first section (0) will show the read books
        // The second section (1) will show the unread books.
        
        if section == 0 {
            return bookController.readBooks.count
        }
    
        // section == 1
        return bookController.unreadBooks.count
    }

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        }
        
        // section == 1
        return bookController.unreadBooks[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell

        // Configure the cell...
        cell.book = bookFor(indexPath: indexPath)
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
            let bookToBeDeleted = bookFor(indexPath: indexPath)
            bookController.delete(book: bookToBeDeleted)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // The title of the first section (0) could be "Read Books"
        // The title of the second section (1) could be "Unread Books"

        if section == 0 {
            return "Read Books"
        }
        
        // section == 1
        return "Unread Books"
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

        guard let bookDetailVC = segue.destination as? BookDetailViewController else {return}
        bookDetailVC.bookController = bookController

        if segue.identifier == "AddBookSegue" {
        } else if segue.identifier == "BookDetailSegue" {
            // Find the book the user tapped on and set the VC's book to it.
            guard let indexPath = tableView?.indexPathForSelectedRow else { return }
            bookDetailVC.book = bookFor(indexPath: indexPath)
        }
    }
}
