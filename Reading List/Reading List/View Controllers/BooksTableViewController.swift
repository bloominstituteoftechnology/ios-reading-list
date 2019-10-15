//
//  BooksTableViewController.swift
//  Reading List
//
//  Created by morse on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    struct PropertyKeys {
        static let bookCell = "BookCell"
        static let viewBookSegue = "ShowBookDetailSegue"
        static let addBookSegue = "AddBookSegue"
    }
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Unread Books"
        default: return "Read Books"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0: return bookController.unreadBooks.count
        default: return bookController.readBooks.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.bookCell, for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)

        return cell
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        switch indexPath.section {
        case 0: return bookController.unreadBooks[indexPath.row]
        default: return bookController.readBooks[indexPath.row]
        }
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
            bookController.deleteBook(named: book)
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
        if segue.identifier == PropertyKeys.addBookSegue {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = bookController
        } else if segue.identifier == PropertyKeys.viewBookSegue {
            print("edit")
            guard let viewBookVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            viewBookVC.bookController = bookController
            viewBookVC.book = bookFor(indexPath: indexPath)
        }
    }
}

extension BooksTableViewController: BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
}
