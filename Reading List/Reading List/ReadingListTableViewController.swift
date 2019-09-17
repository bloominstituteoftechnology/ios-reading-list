//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by admin on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    var bookController = BookController()
    
    var delegate: BookTableViewCellDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        bookController.loadFromPersistentStore()
    }

    // MARK: - Table view data source
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            return bookController.readBooks[indexPath.row]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            guard bookController.unreadBooks.count > 0 else { return nil }
            return "Unread Book"
        } else {
            guard bookController.readBooks.count > 0 else { return nil }
            return "Read Books"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.unreadBooks.count
        } else {
            return bookController.readBooks.count
        }
    }
    


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }

        cell.book = bookFor(indexPath: indexPath)

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
        
        switch indexPath.section {
            case 0:
            if editingStyle == UITableViewCell.EditingStyle.delete {
                bookController.books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                bookController.saveToPersistentStore()}
            case 1:
            if editingStyle == UITableViewCell.EditingStyle.delete{
                bookController.books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                bookController.saveToPersistentStore()}
            default:
            return
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
        if segue.identifier == "AddBookSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        } else if segue.identifier == "BookDetailViewSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.bookController = bookController
            destinationVC.book = bookController.books[indexPath.row]
        }
    }
    

}
