//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Christy Hicks on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    let bookController = BookController()
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return bookController.sortedReadBooks.count == 0 ? "" : "Read Books"
            
        } else if section == 1 {
            
            return bookController.sortedUnreadBooks.count == 0 ? "" : "Unread Books"
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return booksFor(section: section).count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        
        bookCell.delegate = self
        bookCell.book = booksFor(section: indexPath.section)[indexPath.row]
        
        return bookCell
    }



    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                let book = booksFor(section: indexPath.section)[indexPath.row]
                    
                bookController.delete(book: book)
                }
               
        tableView.reloadData()

        }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBookSegue" {
                guard let vc = segue.destination as? BookDetailViewController else { return }
                
                vc.bookController = bookController
                
        } else if segue.identifier == "showBookSegue" {
                
                guard let vc = segue.destination as? BookDetailViewController,
                    
                let cell = sender as? BookTableViewCell else { return }
        
                vc.bookController = bookController
                vc.book = cell.book
                
        }
    }
}

extension ReadingListTableViewController {
func booksFor(section: Int) -> [Book] {
    if section == 0 {
        return bookController.sortedReadBooks
    
    } else if section == 1 {
        return bookController.sortedUnreadBooks
    
    }
    return []
    
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
}
