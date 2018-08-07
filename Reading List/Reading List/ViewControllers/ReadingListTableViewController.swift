//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Lisa Sampson on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistence()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func toggleHasBeenReadButton(for cell: ReadingListTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenRead(book: book)
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read"
        } else if section == 1 {
            return "Un-Read"
        }
        return "Error"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingListCell", for: indexPath) as? ReadingListTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UpdateBookSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow, let detailVC = segue.destination as? DetailViewController else { return }
            let book = bookFor(indexPath: indexPath)
            detailVC.bookController = bookController
            detailVC.book = book
        } else if segue.identifier == "AddBookSegue" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.bookController = bookController
        }
    }
    
    let bookController = BookController()
    
}
