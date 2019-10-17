//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Dennis Rudolph on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reading List"
        
        bookController.delegate = self
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
        let rows: Int
        if section == 0 {
            rows = bookController.readBooks.count
        } else {
            rows = bookController.unreadBooks.count
        }
        return rows
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        let book: Book
        if indexPath.section == 0 {
            book = bookController.readBooks[indexPath.row]
        } else {
            book = bookController.unreadBooks[indexPath.row]
        }
        return book
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
 
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.reloadData()
        }
    }
    
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       if section == 0{
           return "Unread Books"
       } else {
           return "Read Books"
       }
   }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let DetailVC = segue.destination as? BookDetailViewController {
                DetailVC.book = bookFor(indexPath: indexPath)
                DetailVC.bookController = bookController
            }
        } else if segue.identifier == "AddBookSegue" {
            if let AddVC = segue.destination as? BookDetailViewController {
                AddVC.bookController = bookController
            }
        }
    }
}
