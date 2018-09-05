//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    // MARK: - Properties
    let bookController = BookController()
    
    // MARKL - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Table view data source
    //Make two sections, one for read books and one for unread
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    //Return the count of books in each section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }

    //Configure the cell for a given index path
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Make sure the cell can be cast as a book table view cell and get the book for the index.
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        let book = bookFor(indexPath: indexPath)
        
        //Pass the book to the cell and set its delegate
        cell.book = book
        cell.delegate = self

        return cell
    }
    
    //Handle a cell getting deleted
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Get the book for the index path
            let book = bookFor(indexPath: indexPath)
            
            //Delete the book from the model controller and then the row from the table
            bookController.delete(book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //Set titles for each section of the table
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return bookController.readBooks.isEmpty ? nil : "Read Books"
        } else {
            return bookController.unreadBooks.isEmpty ? nil : "Unread Books"
        }
    }
    
    //Set cell height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    // MARK: - Book table view cell delegate
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        //Make sure you can get an index path for the cell and then get the book at that index
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        
        //Update that it has been read and reload the table view's data.
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
        
        let hapticGenerator = UINotificationFeedbackGenerator()
        hapticGenerator.notificationOccurred(.success)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            //The user is adding a book, pass the view the book controller
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
            
        } else if segue.identifier == "ShowBookSegue" {
            //The user is viewing a book, pass the view the book controller and the book.
            guard let destinationVC = segue.destination as? BookDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            let book = bookFor(indexPath: indexPath)
            
            destinationVC.bookController = bookController
            destinationVC.book = book
        }
    }
    
    // MARK: - Private Utility Methods
    //Method to get the book at a given index
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

}
