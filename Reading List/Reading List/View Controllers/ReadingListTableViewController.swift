//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Eoin Lavery on 11/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    //BookController Object for handing model data
    let bookController: BookController = BookController()

    //Reload TableView Data when view is going to appear
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    //Create 2 Sections within tableView for Read books and Unread books
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //Sets Header titles for sections within table
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    //Set number of cells in each section according to number of values in correct array for each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            break
        }
        return 0
    }
    
    //Set cell height to 60 for all cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //Handles creation of cells.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //Returns book from correct array dependent on section of table cell is in
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    // MARK: - Navigation
    // Handles segues between ReadingListTableView and BookDetailView depending on segue used to access view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = bookController
        } else if segue.identifier == "BookDetailSegue" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController,
                    let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
            bookDetailVC.bookController = bookController
            bookDetailVC.book = bookFor(indexPath: selectedIndexPath)
        }
    }

}

//Protocol function to handle updating the hasBeenRead value for a specific book
extension ReadingListTableViewController: BookTableViewDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(book)
        cell.updateViews()
        tableView.reloadData()
    }
}
