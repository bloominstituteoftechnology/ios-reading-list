//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Samuel Esserman on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()

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
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
                return bookController.readBooks.count
            } else if section == 1 {
                return bookController.unreadBooks.count
            }
            return 0
    }
   
    func bookFor(indexPath: IndexPath) -> Book {
       let section = indexPath.section
       if section == 0 {
           return bookController.readBooks[indexPath.row]
       } else {
           return bookController.unreadBooks[indexPath.row]
       }
   }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
           cell.delegate = self
           let book = bookFor(indexPath: indexPath)
           cell.book = book

           return cell
       }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete {
           // Delete the row from the data source
           let book = bookFor(indexPath: indexPath)
           bookController.deletedBook(book: book)
           
           tableView.deleteRows(at: [indexPath], with: .fade)
       } else if editingStyle == .insert {
           // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
       }
   }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
    }
}

  // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "AddBookShowSegue" {
            if let destVC = segue.destination as? BookDetailViewController {
                destVC.bookController = bookController
            }
            
        } else if segue.identifier == "EditBookShowSegue" {
            if let destVC = segue.destination as? BookDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let book = bookFor(indexPath: indexPath)
                    destVC.bookController = bookController
                    destVC.book = book
                    
                }
            }
        }
    }


}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell) {
            let book = bookFor(indexPath: indexPath)
            bookController.updateHasBeenRead(for: book)
            tableView.reloadData()
        }
    }
}
