//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Dennis Rudolph on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows: Int
        if section == 0 {
            rows = bookController.readBooks.count
        } else {
            rows = bookController.unreadBooks.count
        }
        return rows
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        let book: Book
        if indexPath.section == 0 {
            book = bookController.readBooks[indexPath.row]
        } else {
            book = bookController.unreadBooks[indexPath.row]
        }
        return book
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let theBook = cell.book else { return }
        let path: IndexPath
        if theBook.hasBeenRead {
            path.section = 0
            if let row = bookController.readBooks.index(of: theBook) {
            path.row = row
        } else {
            let path = bookController.unreadBooks.index(of: theBook)
        }
        bookController.updateHasBeenRead(for: bookFor(indexPath: path))
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookFor(indexPath: indexPath)
        cell.book = book

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
