//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Gerardo Hernandez on 8/27/21.
//  Copyright © 2021 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    // MARK: - Properties
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unReadBooks[indexPath.row]
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unReadBooks.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Read Books"
        default:
            return "Unread Books"
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddBookSegue" {
            if let addBookVC = segue.destination as? BookDetailViewController {
                addBookVC.bookController = bookController
            }
        } else if segue.identifier == "ShowBookDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let detailVC = segue.destination as? BookDetailViewController {
                    detailVC.bookController = bookController
                    detailVC.book = bookFor(indexPath: indexPath)
                }
            }
            
        }
    }
    
    
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    
}
