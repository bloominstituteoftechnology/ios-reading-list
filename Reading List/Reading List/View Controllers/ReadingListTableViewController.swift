//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by John McCants on 6/8/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    var bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
          if section == 0 {
                  return bookController.readBooks.count
              } else {
                  return bookController.unreadBooks.count
              }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BookTableViewCell else {
            return UITableViewCell()
        }
        
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
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
        if segue.identifier == "Add" {
            if let addVC = segue.destination as? BookDetailViewController {
                addVC.bookController = bookController
            }
        } else {
            if segue.identifier == "Edit" {
                if let editVC = segue.destination as? BookDetailViewController {
                    editVC.bookController = bookController
                    if let indexPath = tableView.indexPathForSelectedRow {
                        editVC.book = bookFor(indexPath: indexPath)
                    }
                }
            }
        }
    }
    

}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadData()
    }
}
