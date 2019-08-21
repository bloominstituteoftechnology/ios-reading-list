//
//  ReadListTableViewController.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    var bc = BookController()

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
        var count: Int = 0
        switch section {
            case 0:
                count = bc.readBooks.count
            case 1:
                count = bc.unreadBooks.count
            default:
                break
        }
        return count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}

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
    
    func bookFor(indexPath: IndexPath) -> Book {
        var book: Book? = nil
        if indexPath.section == 0 {
            book = bc.readBooks[indexPath.row]
        } else if indexPath.section == 1 {
            book =  bc.unreadBooks[indexPath.row]
        }
        return book!
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            //tableView.deleteRows(at: [indexPath], with: .fade)
            bc.delete(which: bc.books[indexPath.row])
            tableView.reloadData()
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "AddBook":
            if let vc = segue.destination as? BookDetailViewController {
                vc.delegate = self
            }
            break
        case "ShowBook":
            if let vc = segue.destination as? BookDetailViewController {
                vc.bc = bc
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.book = bookFor(indexPath: indexPath)
                    vc.delegate = self
                }
            }
        default:
            break
        }
    }
}

extension ReadingListTableViewController:BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let book = cell.book {
            bc.toggleHasBeenRead(which: book)
            tableView.reloadData()
        }
    }
}

extension ReadingListTableViewController:manageBookDelegate {
    func createBook(title: String, reason: String) {
        bc.create(titled: title, withReason: reason)
        tableView.reloadData()
    }
    
    func updateBook(book: Book, title: String?, reason: String?) {
        bc.update(which: book, title, reason)
        tableView.reloadData()
    }
}
