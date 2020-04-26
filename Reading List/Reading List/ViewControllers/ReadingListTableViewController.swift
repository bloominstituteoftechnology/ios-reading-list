//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Clayton Watkins on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
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
        var rows = 0
        if section == 0{
            rows = bookController.readBooks.count
        } else {
            rows = bookController.unreadBooks.count
        }
        return rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            guard bookController.readBooks.count > 0 else { return nil }
            return "Read Books"
        } else {
            guard bookController.unreadBooks.count > 0 else { return nil }
            return "Unread Books"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.removeBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book{
        if indexPath.section == 0{
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let selectedBook = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: selectedBook)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let addBookDestination = segue.destination as? BookDetailViewController else { return }
            addBookDestination.bookController = bookController
        } else if segue.identifier == "BookDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let detailBookDestination = segue.destination as? BookDetailViewController else { return }
            let book = bookFor(indexPath: indexPath)
            detailBookDestination.book = book
            detailBookDestination.bookController = bookController
        }
    }
}

// MARK: - Properties (ex: var booL: Bool()?!
// MARK: - IBOutlets / Computer Props (programmatic code)
// MARK: - Life Cycle
// MARK: - IBActions / @objc funcs (programmatic code)
// MARK: - Helper Functions
// MARK: - Extensions

