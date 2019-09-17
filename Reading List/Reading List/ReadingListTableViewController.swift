//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Gi Pyo Kim on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    var bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.bookController = bookController
            }
        } else if segue.identifier == "ViewDetailSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                bookDetailVC.book = bookFor(indexPath: indexPath)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bookController.unreadBooks.count
        default:
            return bookController.readBooks.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            for i in 0...bookController.books.count-1 {
                if bookController.books[i] == bookFor(indexPath: indexPath) {
                    bookController.delete(book: bookController.books[i])
                    tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Unread Books"
        default:
            return "Read Books"
        }
    }
 
    private func bookFor(indexPath: IndexPath) -> Book{
        switch indexPath.section {
        case 0:
            return bookController.unreadBooks[indexPath.row]
        default:
            return bookController.readBooks[indexPath.row]
        }
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadData()
    }
    
    
}
