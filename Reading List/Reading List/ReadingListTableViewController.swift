//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Daniela Parra on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        
        cell.book = book
        cell.delegate = self
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let book = bookFor(indexPath: indexPath)
            
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if bookController.readBooks.count == 0 {
                return nil
            } else {
                return "Read Books"
            }
        } else {
            if bookController.unreadBooks.count == 0 {
                return nil
            } else {
                return "Unread Books"
            }
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
            
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBook" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            
            destinationVC.bookController = bookController
        } else if segue.identifier == "ViewBook" {
            guard let destinationVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            let book = bookFor(indexPath: indexPath)
            
            destinationVC.bookController = bookController
            destinationVC.book = book
        }
    }
    
    var bookController = BookController()

}
