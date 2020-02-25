//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Wyatt Harrell on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    let bookController = BookController()
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unReadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self

        return cell
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unReadBooks[indexPath.row]
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if bookController.readBooks.count == 0 {
                return ""
            }
            return "Read Books"
        } else {
            if bookController.unReadBooks.count == 0 {
                return ""
            }
            return "Unread Books"
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let book = bookController.books[indexPath.row]
            bookController.delete(book: book)
            //tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            

        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "ShowAddBook" {
            
            guard let showAddBookVC = segue.destination as? BookDetailViewController else {return}
            showAddBookVC.bookController = bookController
            
        } else if segue.identifier == "ShowBookDetail" {
            guard let showAddBookVC = segue.destination as? BookDetailViewController else {return}
            
            guard let selected = tableView.indexPathForSelectedRow else {return}
            showAddBookVC.bookController = bookController
            showAddBookVC.book = bookController.books[selected.row]
        }
        
        
    }


}


extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else { return }
        bookController.updateHasBeenRead(for: book)
        //cell.updateViews()
        tableView.reloadData()
    }
}
