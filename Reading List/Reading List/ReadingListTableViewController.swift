//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Chris Dobek on 3/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        } else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddBookSegue" {
        guard let bookDetailViewController = segue.destination as? BookDetailViewController else { return }
        
        bookDetailViewController.bookController = self.bookController
    } else if segue.identifier == "ShowBookDetailSegue" {
        
        guard let bookDetailViewController = segue.destination as? BookDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        
        bookDetailViewController.book = bookFor(indexPath: indexPath)
        bookDetailViewController.bookController = bookController
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
