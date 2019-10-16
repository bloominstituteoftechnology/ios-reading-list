//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jon Bash on 2019-10-15.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController: BookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
    }
    
    func bookFor(_ indexPath: IndexPath) throws -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else if indexPath.section == 1 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            throw BooksError.noneAtIndexPath
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        } else {
            print(BooksError.unknownTableSection)
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read"
        } else if section == 1 {
            return "Unread"
        } else {
            print(BooksError.unknownTableSection)
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {
            print(BooksError.unknownTableCell)
            return UITableViewCell()
        }

        let book: Book
        do {
            book = try bookFor(indexPath)
        } catch {
            print(error)
            return UITableViewCell()
        }
        
        cell.book = book
        cell.delegate = self
        
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do {
                try bookController.deleteBook(bookFor(indexPath))
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
        
        bookDetailVC.bookController = bookController
        bookDetailVC.delegate = self
        
        if segue.identifier == "ShowBookDetailSegue" {
            guard let tableView = tableView,
                let indexPath = tableView.indexPathForSelectedRow
                else { return }
            
            do {
                bookDetailVC.book = try bookFor(indexPath)
            } catch {
                print(error)
            }
        }
    }

}

extension ReadingListTableViewController: BookTableViewDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else {
            print(BooksError.bookNotInList)
            return
        }
        bookController.toggleHasBeenRead(for: book)
        tableView.reloadData()
    }
}

extension ReadingListTableViewController: BookDetailDelegate {
    func updateViews() {
        tableView.reloadData()
    }
}
