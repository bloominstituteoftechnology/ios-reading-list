//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Nathanael Youngren on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        
        let book = bookFor(indexPath: indexPath)
        
        bookCell.book = book
        bookCell.delegate = self
        
        tableView.reloadData()
        
        return bookCell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
    
        bookController.deleteBook(at: indexPath.row)
        
        tableView.reloadData()
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        
        bookController.updateHasBeenRead(for: book)
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return bookController.readBooks.isEmpty ? nil : "Read Books"
        } else {
            return bookController.unreadBooks.isEmpty ? nil : "Unread Books"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = self.bookController
        } else if segue.identifier == "CellDetailSegue" {
            guard let updateBookVC = segue.destination as? BookDetailViewController,
            let cell = sender as? BookTableViewCell else { return }
            updateBookVC.bookController = self.bookController
            updateBookVC.book = cell.book
        }
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    let bookController = BookController()

}
