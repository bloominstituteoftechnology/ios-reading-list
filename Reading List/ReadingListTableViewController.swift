//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by LaFleur on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            if let addBookVC = segue.destination as? BookDetailViewController {
                addBookVC.bookController = self.bookController
            }
        } else if segue.identifier == "BookShowDetailSegue" {
            if let showBookVC = segue.destination as? BookDetailViewController {
                showBookVC.bookController = self.bookController
                if let indexPath = tableView.indexPathForSelectedRow {
                    showBookVC.book = bookFor(indexPath: indexPath)
                }
            }
        }
    }
    
    // this defines which array (read or unread books) was selected.
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    // creates 2 sections for read and unread
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return bookController.readBooks.count
        default:
            return bookController.unreadBooks.count
        }
            
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        // because multiple sections used, must use the bookFor function
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        // Delete the row from the data source
        //tableView.deleteRows(at: [indexPath], with: .fade)
        bookController.delete(which: bookController.books[indexPath.row])
        tableView.reloadData()
      }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      switch section{
      case 0:
        return "Read Books"
      case 1:
        return "Unread Books"
      default:
        return ""
      }
    }
}

extension ReadingListTableViewController: ToggleSeenDelegate {
    func isSeenButtonTapped(book: Book) {
        tableView.reloadData()
    }
    
    
}

