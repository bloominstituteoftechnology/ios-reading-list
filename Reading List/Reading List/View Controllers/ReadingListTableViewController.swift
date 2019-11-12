//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Alexander Supe on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Protocol Implementations
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        bookController.updateHasBeenRead(for: self.bookFor(indexPath: tableView.indexPath(for: cell)!))
        cell.updateViews()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "Read Books"
            }
        } else {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "Unread Books"
            }
        }
        return nil
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(for: bookFor(indexPath: indexPath))
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
            if let dest = segue.destination as? BookDetailViewController {
                dest.bookController = bookController
            }
        } else if let dest = segue.destination as? BookDetailViewController {
            dest.bookController = bookController
            dest.book = bookFor(indexPath: (tableView?.indexPathForSelectedRow)!)
        }
    }
    
    
}
