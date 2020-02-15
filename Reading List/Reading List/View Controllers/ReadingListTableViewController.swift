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
    }
    // bookController Constant
       let bookController = BookController()
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
   
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return bookController.hasNotBeenRead.count
        } else {
            return bookController.hasBeenRead.count
        }
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
        
        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(with: book)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        if segue.identifier = "AddBookSegue" {
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


