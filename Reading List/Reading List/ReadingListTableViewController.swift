//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by patelpra on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
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
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.bookController.readBooks.count
        default:
            return self.bookController.unreadBooks.count
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return self.bookController.readBooks.count > 0 ? "Read Books" : ""
        default:
            return self.bookController.unreadBooks.count > 0 ? "Unread Books" : ""
        }
    }
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = self.tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        self.bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReadList", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.bookLabel.text = book.title
        cell.delegate = self
        
        let image = book.hasBeenRead == true ? UIImage(named: "checked") : UIImage(named: "unchecked")
        cell.checkViewBox.setImage(image, for: .normal)
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddToDetail" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            bookDetailVC.bookController = self.bookController
        } else if segue.identifier == "ToDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            let book = bookFor(indexPath: indexPath)
            bookDetailVC.book = book
            bookDetailVC.bookController = self.bookController
        }
    }  
}
