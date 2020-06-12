//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Shawn Gee on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

private let readSection = 0
private let unreadSection = 1

class ReadingListTableViewController: UITableViewController {

    // MARK: - Private Properties
    
    private let bookController = BookController()
    
    // MARK: - View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func bookFor(indexPath: IndexPath) -> Book {
        indexPath.section == readSection ? bookController.readBooks[indexPath.row] : bookController.unreadBooks[indexPath.row]
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == readSection ? bookController.readBooks.count : bookController.unreadBooks.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        guard let bookCell = cell as? BookTableViewCell else { fatalError("Unable to dequeue expected type: \(BookTableViewCell.self)") }
        
        bookCell.book = bookFor(indexPath: indexPath)
        bookCell.delegate = self
        
        return bookCell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookController.delete(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == readSection && !bookController.readBooks.isEmpty {
            return "Read Books"
        } else if section == unreadSection && !bookController.unreadBooks.isEmpty{
            return "Unread Books"
        }
        
        return nil
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookDetailVC = segue.destination as? BookDetailViewController {
            bookDetailVC.bookController = bookController
            
            if segue.identifier == "EditBook",
               let indexPath = tableView.indexPathForSelectedRow {
                bookDetailVC.book = bookFor(indexPath: indexPath)
            }
        }
    }

}

// MARK: - BookTableViewCellDelegate

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadData()
    }
}
