//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Michael on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    var bookController = BookController()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleRead(_:)), name: .toggleBeenRead, object: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowCount = 0
        if section == 0 {
            rowCount = bookController.readBooks.count
        }
        if section == 1 {
            rowCount = bookController.unreadBooks.count
        }
        
        return rowCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self

        let book = bookFor(indexPath: indexPath)
        cell.book = book
        
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
            
            bookController.delete(for: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Read Books"
        case 1:
            return "Unread Books"
        default:
            return ""
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

    @objc func toggleRead(_ notification: Notification) {
        if let book = notification.userInfo?["book"] {
            bookController.updateHasBeenRead(for: book as! Book)
            tableView.reloadData()
        }
        
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = bookController
        } else if segue.identifier == "BookDetail" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            bookDetailVC.bookController = bookController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let book = bookFor(indexPath: indexPath)
                bookDetailVC.book = book
            }
        }
    }
    

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = self.tableView.indexPath(for: cell) else { return }
         let bookIndexPath = bookFor(indexPath: indexPath)
        
            bookController.updateHasBeenRead(for: bookIndexPath)
            tableView.reloadData()
        }
    }

