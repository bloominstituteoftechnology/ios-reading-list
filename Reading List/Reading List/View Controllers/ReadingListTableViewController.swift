//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_204 on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func bookFor(indexPath: IndexPath) -> Book {
        if(indexPath.section == 0) {
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
        // return read books
        if (section == 0) {
            return bookController.readBooks.count
        } else if (section == 1){ // return unread books
            return bookController.unreadBooks.count
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Read Books"
        } else if (section == 1) {
            return "Unread Books"
        } else {
            return ""
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "AddBookSegue") {
            if let addBookVC = segue.destination as? BookDetailViewController {
                addBookVC.bookController = bookController
                addBookVC.delegate = self
            }
        } else if (segue.identifier == "BookDetailSegue") {
            if let indexPath = tableView.indexPathForSelectedRow,
                let detailBookVC = segue.destination as? BookDetailViewController {
                detailBookVC.bookController = bookController
                detailBookVC.book = bookFor(indexPath: indexPath)
                detailBookVC.delegate = self
            }
        }
    }

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let book = bookFor(indexPath: indexPath)
            bookController.updateHasBeenRead(for: book)
        }
        tableView.reloadData()
    }
}

extension ReadingListTableViewController: BookDetailViewDelegate {
    func addOrEditBook() {
        if let navController = self.navigationController {
            navController.popToRootViewController(animated: true)
        }
        tableView.reloadData()
    }
}
