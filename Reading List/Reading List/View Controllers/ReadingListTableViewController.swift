//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks()[indexPath.row]
        } else {
            return bookController.unreadBooks()[indexPath.row]
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionTitle = ""
        if section == 0 {
            sectionTitle = "Read Books"
        }
        if section == 1 {
            sectionTitle = "Unread Books"
        }
        return sectionTitle
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber = 0
        
        if section == 0 {
            rowNumber = bookController.readBooks().count
        }
        if section == 1 {
            rowNumber = bookController.unreadBooks().count
        }
        return rowNumber
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell
        else { return UITableViewCell() }
        cell.delegate = self
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        return cell

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            let addBookVC = segue.destination as! DetailViewController
            addBookVC.bookController = bookController
        } else if segue.identifier == "DetailViewSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
            let detailVC = segue.destination as? DetailViewController {
                detailVC.bookController = bookController
                detailVC.book = bookFor(indexPath: indexPath)
            }
        }
    }

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
        }
    }
}

//extension ReadingListTableViewController: TableViewBookDelegate {
//    func addBookAndReason(_ book: String, _ reason: String) {
//        bookController.books.append(book)
//        tableView.reloadData()
//    }
//}
