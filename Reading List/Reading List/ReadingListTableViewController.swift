//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by macbook on 9/17/19.
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
        
        if section == 0 {
            return bookController.readBooks.count
            
        }
        
        if section == 1 {
            return bookController.unreadBooks.count
        }
        
    }

    
    
    // MARK: - Creating new Cell
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book

        
        return cell
      
    }
    
    // MARK - bookfor(indexPath) func
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
    // MARK: - Configuring Titles for Header in Sections
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    
    // TODO: - You only need to worry about the .delete case.
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            tableView.deleteRows(at: [indexPath], with: .fade)
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

    
    // MARK: - Navigation  ->  Prepare for Segue
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            if let addBookVC = segue.destination as? BookDetailViewController {
                //addBookVC.delegate = self
            }
        }
        // TODO: - do the same thing as step 1, and also pass a Book object that was selected in the table view to the destination view controller's book property as well.
        else if segue.identifier == "ShowUpdateSegue" {
            
            if let detailBookVC = segue.destination as? BookDetailViewController {
             detailBookVC.book =
            }
            
//            if let indexPath = tableView.indexPathForSelectedRow,
//                let friendDetailVC = segue.destination as? FriendDetailViewController {
//                friendDetailVC.friend = friends[indexPath.row]
//            }
        }
    }
    

}



// MARK: - Conforming to the BookTableViewDelegate protocol

extension ReadingListTableViewController: BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
        // TODO: - You will need an instance of Book to pass in to this function.
        bookController.updateHasBeenRead(for: )
        tableView.reloadData()
    }

    
}

//extension ReadingListTableViewController: UITableViewDataSource {
//
//}
