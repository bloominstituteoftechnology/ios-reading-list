//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Angel Buenrostro on 1/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()
    
    override func viewDidAppear(_ animated: Bool) {
        bookController.loadFromPersistentStore()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()

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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let firstSectionCount = bookController.readBooks.count
        let secondSectionCount = bookController.unReadBooks.count
        
        if section == 0 {
            return firstSectionCount
        } else if section == 1 {
            return secondSectionCount
        }
        fatalError("Number of Section rows could not be computed.")
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookcell", for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        
        
        let book = bookFor(indexPath: indexPath)
        bookCell.book = book
        bookCell.delegate = self
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
            let deletedBook = bookFor(indexPath: indexPath)
            bookController.Delete(bookToDelete: deletedBook)
            tableView.deleteRows(at: [indexPath], with: .fade)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        switch segue.identifier{
        case "addDetailSegue":
            let detailVC = segue.destination as! BookDetailViewController
            detailVC.bookController = bookController
        case "cellDetailSegue":
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let detailVC = segue.destination as! BookDetailViewController
            let book = bookFor(indexPath: indexPath!)
            detailVC.bookController = bookController
            detailVC.book = book
        case .none:
            return
        case .some(_):
            return
        }
        return
    }
    
    
    //Conditional Section Checking Logic
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unReadBooks[indexPath.row]
        }
        
    }
    
    
    // Delegate Func Implementation
    
    
 //   TODO: [Need to refactor this to find the correct indexPath for needed book]
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }

}
