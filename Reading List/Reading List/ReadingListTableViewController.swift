//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateReadStatus(for: book)
        tableView.reloadSections(IndexSet(0...1), with: .fade)
    }
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let amountOfReadBooks = bookController.readBooks.count
        let amountOfUnreadBooks = bookController.unreadBooks.count
        
        if section == 0 {
            return amountOfReadBooks
        } else if section == 1 {
            return amountOfUnreadBooks
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book = bookFor(indexPath: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        
        bookCell.book = book
        bookCell.delegate = self
        
        return bookCell
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else if section == 1 {
            return "Unread Books"
        } else { return "" }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
            if let vc = segue.destination as? BookDetailViewController {
                vc.bookController = bookController
            }
        } else if segue.identifier == "UpdateBook" {
            if let vc = segue.destination as? BookDetailViewController {
                vc.bookController = bookController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    vc.book = bookController.books[indexPath.row]
                }
            }
        }
    }
    
    let bookController = BookController()
}
