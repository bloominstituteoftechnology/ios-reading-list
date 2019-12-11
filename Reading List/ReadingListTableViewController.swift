//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Osha Washington on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
         return "Read Books"
        } else {
         return "Unread Books"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                   return bookController.readBooks.count
               } else {
                   return bookController.unreadBooks.count
        }
    }
    func bookFor(indexPath: IndexPath) -> Book {
    if indexPath.section == 0 {
        return bookController.readBooks[indexPath.row]
    } else {
        return bookController.unreadBooks[indexPath.row]
        }
    }
        

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}

        let book = bookController.books[indexPath.row]
         cell.book = book
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "AddButtonTapped" {
        if let indexPath = tableView.indexPathForSelectedRow,
            let DetailVC = segue.destination as? BookDetailViewController {
            DetailVC.book = bookFor(indexPath: indexPath)
            DetailVC.bookController = bookController
        }
    } else if segue.identifier == "TableViewCellShowDetail" {
        if let AddVC = segue.destination as? BookDetailViewController {
            AddVC.bookController = bookController
        }
    }

}
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            tableView.reloadData()
        }
        }
    }
    


