//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Ilgar Ilyasov on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    // MARK: - Properties
    
    let bookController = BookController()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
            
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let theBook = bookFor(indexPath: index)
        
        bookController.updateHasBeenRead(for: theBook)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "readingListTableCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let theBook = bookFor(indexPath: indexPath)
        
        cell.book = theBook
        cell.cellDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let theBook = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: theBook)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addButtonSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
            
        } else if segue.identifier == "tableViewCellSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
            
            guard let index = tableView.indexPathForSelectedRow else { return }
            let theBook = bookFor(indexPath: index)
            
            destinationVC.book = theBook
        }
    }
}
