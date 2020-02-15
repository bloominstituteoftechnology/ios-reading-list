//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by David Williams on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    let bookController = BookController()
    
    func toggleHasBeenread(for cell: BookTableViewCell) {
        if let book = cell.book {
            bookController.updateHasBeenRead(for: book)
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        switch section {
        case 0:
            count = bookController.readBooks.count
        case 1:
            count = bookController.unreadBooks.count
        default:
            break
        }
        return count
    }
   
    
    private func bookFor(indexPath: IndexPath) -> Book {
        var book: Book?// = nil
        
        if indexPath.section == 0 {
            var books: [Book] = []
            book = bookController.readBooks[indexPath.row]
           //-> book)
        } else if indexPath.section == 1 {
            book = bookController.unreadBooks[indexPath.row]
        }
        return book!
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }

        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch  section {
        case 0:
            return "I read these books:"
        case 1:
            return "I have not read these books:"
        default:
            return ""
        }
    }
  
        // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.deleteBook(which: bookController.books[indexPath.row])
            tableView.reloadData()
    }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addBookSegue":
            if let bookVC = segue.destination as? BookDetailViewController {
                bookVC.bookcontroller = self.bookController
            }
        case "showBookSegue":
            if let bookVC = segue.destination as? BookDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    bookVC.book = bookFor(indexPath: indexPath)
                    bookVC.bookcontroller = self.bookController
                }
            }
        default:
            break
        }
    }
}
