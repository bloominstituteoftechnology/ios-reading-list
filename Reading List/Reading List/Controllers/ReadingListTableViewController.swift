//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate, DetailViewDelegate {

    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell else { fatalError() }
        
        let book = bookFor(indexPath: indexPath)
        
        cell.book = book
        cell.delegate = self
        cell.updateViews()
        
        return cell
        
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                bookController.delete(for: bookFor(indexPath: indexPath))
                updateView()
            } else if indexPath.section == 1 {
                bookController.delete(for: bookFor(indexPath: indexPath))
                updateView()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewBookView" {
            guard let detailVC = segue.destination as? BookDetailViewController else { return }
            detailVC.delegate = self
            detailVC.bookController = bookController
            
        } else if segue.identifier == "DetailBookView" {
            guard let detailVC = segue.destination as? BookDetailViewController,
               let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.bookController = bookController
            detailVC.book = bookFor(indexPath: indexPath)
            detailVC.delegate = self
            
        }

    }

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        updateView()
    }
    
    func updateView() {
        bookController.saveToPersistentStore()
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }

}
