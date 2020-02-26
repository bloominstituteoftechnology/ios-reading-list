//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Nichole Davidson on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    var books: [Book] = []
    var bookController: BookController
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        var book = books[indexPath.row]
        book.hasBeenRead.toggle()
        tableView.reloadData()
        bookController.updateHasBeenRead(for: book)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let section = tableView.numberOfSections
        
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath)
        
        let book = bookController.books[indexPath.row]
        
        cell.textLabel?.text = book.title
        
//        set the cell's delegate property
      

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = tableView.numberOfSections
        
        if section == 0 {
            print("Read Books")
        } else {
            print("Unread Books")
        }
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            if let newBookVC = segue.destination as? BookDetailViewController {
                newBookVC.delegate = self
            }
        
        } else if segue.identifier == "BookDetailSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.delegate = self
            }
        }
    }

}
