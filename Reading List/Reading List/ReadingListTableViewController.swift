//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Victor  on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    //delegation pattern to toggle for the books read property
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let book = bookFor(indexPath: indexPath)
        bookController.updateBookHasBeenRead(for: book)
        tableView.reloadSections(IndexSet(0...1), with: .fade)
    }
    
    //passing controller
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //seting sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //setting number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        } else {
            return 0
        }
    }
    
    //setting each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let book = bookFor(indexPath: indexPath)
        
        guard let bookCell = cell as? BookTableViewCell else {return cell}
        
        bookCell.book = book
        bookCell.delegate = self
        
        return cell
    }
    
    //calls delete book method then deletes from row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //implement prepare
        //logic to know which segue
        if segue.identifier == "addBook" {
            if let vc = segue.destination as? BookDetailViewController {
                //updating book detail view controller
                    vc.navigationItem.title = "Add New Book"
                    vc.bookController = bookController
            }
        } else if segue.identifier == "cellBook" {
            if let vc = segue.destination as? BookDetailViewController {
                vc.navigationItem.title = "Update Book"
                vc.bookController = bookController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    vc.book = bookFor(indexPath: indexPath)
                }
            }
            
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    //setting header
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Read Books"
        } else if (section == 1) {
            return "Unread Books"
        } else {
            return nil
        }
    }
    
    //logic to get book index path
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
}
