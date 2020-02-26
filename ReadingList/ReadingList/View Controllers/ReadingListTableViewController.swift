//
//  ReadingListTableViewController.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    // MARK: - Properties
    let bookController = BookController()
    var book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
        if segue.identifier == "AddBookSegue" {
            let addBookVC = segue.destination as! BookDetailViewController
            addBookVC.bookController = bookController
        } else if segue.identifier == "ShowBookSegue" {
            guard let showBookVC = segue.destination as? BookDetailViewController, let index = tableView.indexPathForSelectedRow else { return }
            showBookVC.bookController = bookController
            showBookVC.book = bookFor(indexPath: index)
        }
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: bookFor(indexPath: index))
        tableView.reloadData()
    }
    
    
}
