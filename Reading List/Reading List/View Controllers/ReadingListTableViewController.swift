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
    
    func bookFor(indexPath: IndexPath) -> Book {
        let readBooks = bookController.readBooks()
        let unreadBooks = bookController.unreadBooks()
        if indexPath.section == 0 {
            return readBooks[indexPath.row]
        } else {
            return unreadBooks[indexPath.row]
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let indexPath = tableView.indexPathForSelectedRow
        let sectionNumber = indexPath?.section
        if sectionNumber == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let indexPath = tableView.indexPathForSelectedRow
        let sectionNumber = indexPath?.section
        let readBooks = bookController.readBooks()
        let unreadBooks = bookController.unreadBooks()
        if sectionNumber == 0 {
            return readBooks.count
        } else {
            return unreadBooks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = bookController.books[indexPath.row]
        cell.textLabel?.text = book.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            let addBookVC = segue.destination as! DetailViewController
            addBookVC.delegate = self
            addBookVC.bookController = self.bookController
        } else if segue.identifier == "BookCell" {
            let detailVC = segue.destination as! DetailViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.book = bookFor(indexPath: indexPath)
        }
    }

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let currentIndexPath = tableView.indexPathForSelectedRow else { return }
        let book = bookFor(indexPath: currentIndexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
}
