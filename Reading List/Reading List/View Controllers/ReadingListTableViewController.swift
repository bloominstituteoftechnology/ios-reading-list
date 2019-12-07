//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jeremy Taylor on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        }
            return bookController.unreadBooks.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { fatalError("Can't get BookTableViewCell") }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        }
        return "Unread Books"
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            
            destinationVC.bookController = bookController
        } else if segue.identifier == "ShowBookDetail" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let book = bookFor(indexPath: indexPath)
            
            destinationVC.bookController = bookController
            destinationVC.book = book
        }
    }
    

    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let book = bookFor(indexPath: indexPath)
        
        bookController.updateHasBeenRead(for: book)
        
        tableView.reloadData()
    }
}
