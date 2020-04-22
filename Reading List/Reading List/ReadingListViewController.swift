//
//  ReadingListViewController.swift
//  Reading List
//
//  Created by Vincent Hoang on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import os.log

class ReadingListViewController: UITableViewController, BookTableViewCellDelegate {
    

    let bookController = BookController()
    
    var delegate: BookTableViewCellDelegate?
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        }
        
        return bookController.unreadBooks.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.books.remove(at: indexPath.row)
            bookController.saveToPersistentStore()
            tableView.reloadData()
        }
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        }
        
        return bookController.unreadBooks[indexPath.row]
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            fatalError("Dequeued cell was not found in tableView")
        }

        let book = bookFor(indexPath: indexPath)

        bookController.updateHasBeenRead(for: book)
    
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        }
        
        return "Unread Books"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "readingListCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BookTableViewCell else {
            fatalError("The dequeued cell is not an instance of BookTableViewCell")
        }
        
        let book = bookFor(indexPath: indexPath)
        
        cell.titleLabel?.text = book.title
        cell.delegate = self
        
        if book.hasBeenRead {
            cell.hasReadButton?.setImage(UIImage(named: "checked"), for: .normal)
            cell.hasReadButton?.isSelected = false
        } else {
            cell.hasReadButton?.setImage(UIImage(named: "unchecked"), for: .selected)
            cell.hasReadButton?.isSelected = true
        }
        
        return cell
    }
    
    @IBAction func unwindToReadingList(_ sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? BookDetailViewController, let book = sourceViewController.book {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                let selectedBook = bookFor(indexPath: selectedIndexPath)
                bookController.updateBook(for: selectedBook, book.title, book.reasonToRead)
                
                if book.hasBeenRead != selectedBook.hasBeenRead {
                    bookController.updateHasBeenRead(for: selectedBook)
                }
            } else {
                bookController.create(book.title, book.reasonToRead)
                tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "detailSegue":
            guard let bookDetailViewController = segue.destination as? BookDetailViewController else {
                fatalError("Unexpected detination: \(segue.destination)")
            }
            
            guard let selectedBookCell = sender as? BookTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "No sender available")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedBookCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            os_log("IndexPath %@", log: OSLog.default, type: .debug, "\(indexPath.section)")
            
            let selectedBook = bookFor(indexPath: indexPath)
            
            bookDetailViewController.book = selectedBook
            
        case "addSegue":
            os_log("Adding a new book", log: OSLog.default, type: .debug)
            
        default:
            fatalError("Unexpected segue identifier: \(segue.identifier ?? "No segue available")")
        }
    }
}
