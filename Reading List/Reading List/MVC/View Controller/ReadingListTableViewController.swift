//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Cameron Collins on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    //Variables
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count 
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)

        guard let myCell = cell as? BookTableViewCell else {
                return cell
            }
        
        myCell.delegate = self
        myCell.book = bookFor(indexPath: indexPath)
        
        return myCell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            if editingStyle == .delete {
                bookController.books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadData()
            }
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let myIdentifier = segue.identifier {
            if myIdentifier == "AddBookSegue" {
                guard let myDestination = segue.destination as? BookDetailViewController else {
                    return
                }
                myDestination.bookController = bookController
                myDestination.previousController = self
            } else if myIdentifier == "BookDetailSegue" {
                guard let myDestination = segue.destination as? BookDetailViewController else {
                    return
                }
                myDestination.bookController = bookController
                myDestination.book = bookController.books[tableView.indexPathForSelectedRow?.row ?? 0]
                 myDestination.previousController = self
            }
        }
    }
}


extension ReadingListTableViewController: BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        bookController.updateHasBeenRead(for: bookController.books[tableView.indexPathForSelectedRow?.row ?? 0])
        tableView.reloadData()
    }
}
