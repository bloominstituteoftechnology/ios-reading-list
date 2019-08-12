//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Bobby Keffury on 8/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
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
        } else {
            return bookController.unreadBooks.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)

        return cell
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
            let book = bookController.books[indexPath.row]
            bookController.deleteBook(for: book)
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
        if segue.identifier == "addBookSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        } else if segue.identifier == "bookDetailViewSegue" {
            guard let destinationVC = segue.destination as? BookDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
            
            destinationVC.book = bookFor(indexPath: indexPath)
            destinationVC.bookController = bookController
        }
    }
    

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
           let book = bookFor(indexPath: indexPath)
             bookController.updateHasBeenRead(for: book)
            tableView.reloadData()
        }
        
    }
    
    
}

