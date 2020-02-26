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

        //print(tableView.dataSource)
        tableView.dataSource = self
        // Observed to be the same before and after
        //print(tableView.dataSource)

        // TODO: Why doesn't "Storyboard > Large Title > Always" work?
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // TODO: New/Changed books were now showing up. This fixed it. Correct way?
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Delegate
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let bookFromCell = cell.book else { return }
        bookController.toogleHasBeenRead(book: bookFromCell)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    var numOfSections: Int {
        var numOfSections = 0
        
        if bookController.readBooks.count > 0 {
            numOfSections += 1
        }
        
        if bookController.unreadBooks.count > 0 {
            numOfSections += 1
        }
        
        return numOfSections
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        let num = numOfSections
        //print("numOfSections: \(numOfSections)")
        return num
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // The first section (0) will show the read books
        // The second section (1) will show the unread books.
        
        if numOfSections == 2 {
            if section == 0 {
                return bookController.readBooks.count
            }
            
            // section == 1
            return bookController.unreadBooks.count
        }
        
        if bookController.readBooks.count > 0 {
            return bookController.readBooks.count
        }
        
        if bookController.unreadBooks.count > 0 {
            return bookController.unreadBooks.count
        }
        
        return 0
    }

    func bookFor(indexPath: IndexPath) -> Book {
        if numOfSections == 2 {
            if indexPath.section == 0 {
                return bookController.readBooks[indexPath.row]
            }
            
            // section == 1
            return bookController.unreadBooks[indexPath.row]
        }
        
        if bookController.readBooks.count > 0 {
            return bookController.readBooks[indexPath.row]
        }
        
        if bookController.unreadBooks.count > 0 {
            return bookController.unreadBooks[indexPath.row]
        }
        
        return Book(title: "", reasonToRead: "")
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

    // Using this override to support deleting an entry in the table view.
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

        if numOfSections == 2 {
            if section == 0 {
                return "Read Books"
            }
            
            // section == 1
            return "Unread Books"
        }

        if bookController.readBooks.count > 0 {
            return "Read Books"
        }
        
        if bookController.unreadBooks.count > 0 {
            return "Unread Books"
        }
        
        return "!!!"
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
