//
//  ReadingListTableViewController.swift
//  ReadingList
//
//  Created by Jocelyn Stuart on 1/17/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    
    
    
    let bookController = BookController()
    
   // let book = Book?

    override func viewDidLoad() {
        super.viewDidLoad()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let book = bookFor(indexPath: indexPath)
        
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        // Implement here
        let book = bookController.books[indexPath.row]
        bookController.delete(book: book)
        tableView.reloadData()
        
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookDetail" {
            guard let cellDetailController = segue.destination as? BookDetailViewController, let cell = sender as? BookTableViewCell else { return }
            
            cellDetailController.bookController = bookController
            cellDetailController.book = cell.book
            
    } else if segue.identifier == "addBook" {
            guard let addBookController = segue.destination as? BookDetailViewController else { return }
        
            addBookController.bookController = bookController
    
        }
    }
}
