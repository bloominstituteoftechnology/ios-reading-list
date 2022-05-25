//
//  BooksTableViewController.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/23/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

//MARK: - Properties
    let bookController = BookController()
    
//MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        var book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: &book)
        tableView.reloadData()
        cell.updateViews()
    }

// MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        let currentBook = bookFor(indexPath: indexPath)
        cell.book = currentBook
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            guard let index = bookController.books.firstIndex(of: book) else { return }
            bookController.books.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewBookSegueID" {
            let newBookVC = segue.destination as! BookDetailViewController
            newBookVC.bookController = bookController
        } else if segue.identifier == "BookDetailSegueID" {
            let detailBookVC = segue.destination as! BookDetailViewController
            let selectedBook = bookFor(indexPath: tableView.indexPathForSelectedRow!)
            detailBookVC.bookController = bookController
            detailBookVC.book = selectedBook
        }
    }
    
}
