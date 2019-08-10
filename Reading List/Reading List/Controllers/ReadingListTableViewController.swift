//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by John Kouris on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }

    // MARK: - Table view data source

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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        } else if segue.identifier == "ShowBookDetailSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.bookController = bookController
            destinationVC.book = bookController.books[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.delete(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var book = bookController.books[indexPath.row]
        bookController.updateHasBeenRead(for: book)
        
        tableView.reloadData()
    }
    
}
