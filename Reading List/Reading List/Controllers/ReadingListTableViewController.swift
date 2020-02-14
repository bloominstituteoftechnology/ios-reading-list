//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by David Williams on 12/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
  
    var bookC = BookController()

    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let book = cell.book {
            bookC.updateHasBeenRead(for: book)
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
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        switch section {
        case 0:
            count = bookC.readBooks.count
        case 1:
            count = bookC.unreadBooks.count
        default:
            break
        }
        return count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }

        // Configure the cell...
        
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           switch section{
           case 0:
               return "Read Books"
           case 1:
               return "Unread Books"
           default:
               return ""
           }
       }
    
     private func bookFor(indexPath: IndexPath) -> Book {
        var book: Book? = nil
            if indexPath.section == 0 {
                book = bookC.readBooks[indexPath.row]
            } else if indexPath.section == 1 {
                book = bookC.unreadBooks[indexPath.row]
                }
        return book!
        }
   
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bookC.deleteBook(which: bookC.books[indexPath.row])
            tableView.reloadData()
        }
    }
   
    // MARK: - Navigation

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addBookSegue":
            if let vc = segue.destination as? BookDetailViewController {
                vc.bookController = self.bookC
            }
            break
        case "showBookSegue":
            if let vc = segue.destination as? BookDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.book = bookFor(indexPath: indexPath)
                    vc.bookController = self.bookC
                }
            }
        default:
            break
        }
    }
}
