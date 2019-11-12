//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Chad Rutherford on 11/12/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Properties
    let bookController = BookController()
    
    private func book(for indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Segues.addBook:
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            bookDetailVC.bookController = bookController
        case Segues.showBookDetail:
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            bookDetailVC.bookController = bookController
            bookDetailVC.book = book(for: indexPath)
        default:
            break
        }
    }
    
    // --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
    // MARK: - TableView DataSource/Delegate Methods
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if bookController.readBooks.isEmpty {
                return nil
            } else {
                return "Read Books"
            }
        } else {
            if bookController.unreadBooks.isEmpty {
                return nil
            } else {
                return "Unread Books"
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.bookCell, for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.book = book(for: indexPath)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let book = self.book(for: indexPath)
            guard let index = bookController.books.firstIndex(of: book) else { return }
            bookController.books.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
}

// --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - BookTableViewCell Delegate Extension
extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = self.book(for: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
}
