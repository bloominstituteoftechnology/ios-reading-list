//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Bronson Mullens on 4/27/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadSections(IndexSet(0...1), with: .fade) // Try .automatic
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfReadBooks = bookController.readBooks.count
        let numberOfUnreadBooks = bookController.unreadBooks.count
        
        if section == 0 {
            return numberOfReadBooks
        } else if section == 1 {
            return numberOfUnreadBooks
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = bookFor(indexPath: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        
        bookCell.book = book
        bookCell.delegate = self
        bookCell.updateViews()
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(bookToDelete: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else if section == 1 {
            return "Unread Books"
        } else {
            return "" // An empty string will not give us a title
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailSegue" {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                let bookDetailVC = segue.destination as! BookDetailViewController
                bookDetailVC.bookController = bookController
                bookDetailVC.book = bookFor(indexPath: indexPath)
            }
            
        } else if segue.identifier == "AddBookSegue" {
            let newBookVC = segue.destination as! BookDetailViewController
            newBookVC.bookController = bookController
        }
    }
}
