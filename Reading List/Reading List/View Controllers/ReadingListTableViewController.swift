//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Rob Vance on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        bookController.loadFromPersistentStore()
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // bookController Constant
       let bookController = BookController()
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return bookController.hasNotBeenRead.count
        } else if section == 1 {
            return bookController.hasBeenRead.count
        }
        return 0
    }
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.hasNotBeenRead[indexPath.row]
        } else {
            return bookController.hasBeenRead[indexPath.row]
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell() }
        cell.delegate = self
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row form the data source
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(with: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
        tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            if let addBookVC = segue.destination as? BookDetailViewController {
                addBookVC.bookController = bookController
            }
        } else if segue.identifier == "BookDetailSegue" {
            if let editBookVC = segue.destination as? BookDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let book = bookFor(indexPath: indexPath)
                    editBookVC.bookController = bookController
                    editBookVC.book = book
                    
                }
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


