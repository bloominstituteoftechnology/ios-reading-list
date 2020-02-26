//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Bradley Diroff on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewDelegate {
    
    var bookController = BookController()
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            print("this is section 0")
            return bookController.readBooks[indexPath.row]
        } else {
            print("this is section 1")
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
        if let book = cell.book {
            bookController.updateRead(with: book)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
         //   print("THERES BOOKS HERE")
            return bookController.readBooks.count
        } else {
            print("THERES BOOKS HERE")
            return bookController.unreadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {
            print("NO CELL COMING UP")
            return UITableViewCell()}

        print("CELL COMING UP")
        let book = bookFor(indexPath: indexPath)
        print(indexPath.section)
        print(book.title)
        cell.book = book
        cell.delegate = self

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(with: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if bookController.readBooks.count > 0 {
                return "Read Books"
            } else {
                return nil
            }
            
        } else {
            if bookController.unreadBooks.count > 0 {
                 return "Unread Books"
             } else {
                 return nil
             }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                if segue.identifier == "AddSegue" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else {return}
            bookDetailVC.bookController = bookController
                    bookDetailVC.delegate = self
                } else {
                    if segue.identifier == "CellSegue" {
                    guard let bookDetailVC = segue.destination as? BookDetailViewController else {return}
                        bookDetailVC.bookController = bookController
                        guard let newIndex = self.tableView.indexPathForSelectedRow else {return}
                        let booked = bookFor(indexPath: newIndex)
                        bookDetailVC.book = booked
                        bookDetailVC.delegate = self
                    }
        }
    }
}

extension ReadingListTableViewController: AddBookDelegate {
    
    func bookWasAdded(_ book: Book) {
        bookController.createBook(with: book.title, reason: book.reasonToRead)
        tableView.reloadData()
    }
    
    func bookWasUpdated(oldBook: Book, title: String, reason: String) {
        bookController.updateTitleOrReasson(with: oldBook, title: title, reason: reason)
        tableView.reloadData()
    }
                
}
