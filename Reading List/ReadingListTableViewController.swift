//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Alex Thompson on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

     override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            tableView.reloadData()
        }
        
        func toggleHasBeenReadFor(cell: BookTableViewCell) {
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
            } else {
                return bookController.unreadBooks.count
            }
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
            
            cell.delegate = self
            
            let book = bookFor(indexPath: indexPath)
            
            cell.book = book
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
            if section == 0 {
                guard bookController.readBooks.count > 0 else { return nil }
                return "Read Books"
            } else {
                guard bookController.unreadBooks.count > 0 else { return nil }
                return "Unread Books"
            }
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let book = bookFor(indexPath: indexPath)
                
                bookController.removeBook(title: book)
                
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
        
        private func bookFor(indexPath: IndexPath) -> Book {
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
                guard let indexPath = tableView.indexPathForSelectedRow,
                    let destinationVC = segue.destination as? BookDetailViewController else { return }
                
                let book = bookFor(indexPath: indexPath)
                
                destinationVC.book = book
                destinationVC.bookController = bookController
            }
        }
        
        var bookController = BookController()
    }


//extension ReadingListTableViewController: BookTableViewCellDelegate {
//    func toggleHasBeenRead(for cell: BookTableViewCell) {
//        guard let book = cell.book else {return}
//
//        bookController.updateHasBeenRead(for: book)
//    }
//}
