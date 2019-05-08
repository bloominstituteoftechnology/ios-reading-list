//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Kobe McKee on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
 
//    weak var delegate: BookTableViewCellDelegate?
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenRead(book: book)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch (section) {
        case 0:
            return bookController.readBooks.count
        default:
            return bookController.unreadBooks.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        let book = bookFor(indexPath: indexPath)
        
        bookCell.book = book
        bookCell.delegate = self

        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Read Books"
        default:
            return "Unread Books"
        }
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            destinationVC.bookController = bookController
        }
        else if segue.identifier == "BookDetailSegue" {
            
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            guard let index = tableView.indexPathForSelectedRow else { return }
            destinationVC.bookController = bookController
            destinationVC.book = bookFor(indexPath: index)
            
        }
        
    }


}
