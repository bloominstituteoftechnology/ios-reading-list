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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
