//
//  ReadingListTableTableViewController.swift
//  Reading List
//
//  Created by James Sedlacek on 6/5/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController: BookController = BookController()

    override func viewDidLoad() {
        bookController.loadFromPersistentStore()
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        bookController.loadFromPersistentStore()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 //read and unread books
    }

    override func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}

        cell.delegate = self
        if indexPath.section == 0 {
            if bookFor(indexPath: indexPath).hasBeenRead {
                cell.bookTitleLabel.text = bookFor(indexPath: indexPath).title
                cell.checkbox.setImage(UIImage(named: "checked"), for: .normal)
            }
        } else {
            if !bookFor(indexPath: indexPath).hasBeenRead {
                cell.bookTitleLabel.text = bookFor(indexPath: indexPath).title
                cell.checkbox.setImage(UIImage(named: "unchecked"), for: .normal)
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
/*
         Check the segue's identifier property using a conditional statement.
         If it's the one from the "Add" bar button item,
         then this means the user wants to create a new Book.
         Pass the bookController variable in the table view controller
         to the segue's destination view controller.
         (You will need to cast the destination as the correctly typed view controller)
*/
        if segue.identifier == "addSegue" {
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.bookController = self.bookController
            }
        } else if segue.identifier == "cellSegue" {
/*
             If the segue's identifier matches the cell's segue identifier,
             do the same thing as step 1, and also
             pass a Book object that was selected in the table view
             to the destination view controller's book property as well.
*/
            if let bookDetailVC = segue.destination as? BookDetailViewController {
                bookDetailVC.book = bookFor(indexPath: tableView.indexPathForSelectedRow!)
                bookDetailVC.bookController = self.bookController
            }
        }
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        //The function should call the BookController's updateHasBeenRead(for: Book) method
        //You will need an instance of Book to pass in to this function.
        bookController.updateHasBeenRead(for: bookFor(indexPath: self.tableView.indexPath(for: cell)!))
        //At the end of this function, reload the table view.
        tableView.reloadData()
    }
}

