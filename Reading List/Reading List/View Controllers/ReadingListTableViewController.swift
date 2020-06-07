//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Norlan Tibanear on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    
    // Variables
    var bookController = BookController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    } //
    
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }

        cell.delegate = self
        
        let book = bookFor(indexPath: indexPath)
        
        cell.book = book

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    } //
    

    

    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
            if let addBook = segue.destination as? BookDetailViewController {
                addBook.bookController = bookController
            }
        } else {
            if segue.identifier == "EditBook" {
                if let editDetail = segue.destination as? BookDetailViewController {
                    editDetail.bookController = bookController
                    if let indexPath = tableView.indexPathForSelectedRow {
                        editDetail.book = bookFor(indexPath: indexPath)
                    }
                }
            }
        }
    }

} // END
