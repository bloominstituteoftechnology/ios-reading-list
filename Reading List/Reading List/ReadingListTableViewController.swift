//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Josh Kocsis on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let thisBook = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: thisBook)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        }
        if section == 1 {
            return bookController.unreadBooks.count
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            guard bookController.readBooks.count > 0 else { return nil }
            return "Read Books"
        } else {
            guard bookController.unreadBooks.count > 0 else { return nil }
            return "Unread Books"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewBookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddButtonSegue" {
            guard let addBook = segue.destination as? BookDetailViewController else { return }
            addBook.bookController = bookController
        } else if segue.identifier == "ReadingDetailSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow, let viewDetail = segue.destination as? BookDetailViewController else { return }
            let book = bookFor(indexPath: indexPath)
            viewDetail.book = book
            viewDetail.bookController = bookController
        }
    }
}
