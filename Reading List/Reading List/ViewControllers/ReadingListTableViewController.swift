//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Seschwan on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookController.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
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
        // #warning Incomplete implementation, return the number of rows
        switch (section) {
        case 0:
            return bookController.readBooks.count
        default:
            return bookController.unreadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.bookTableCellDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBookFromList(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Read Books"
        default:
            return "Unread Books"
        }
    }
        
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddVC" {
            guard let destinationVC = segue.destination as? BookDetailViewController
                else {
                    return
            }
            destinationVC.bookController = bookController
            
        } else if segue.identifier == "toBookDetailSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController
                else {
                    return
            }
            guard let index = tableView.indexPathForSelectedRow
                else {
                    return
            }
            destinationVC.bookController = bookController
            destinationVC.book = bookFor(indexPath: index)
        }
    }

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    
}
