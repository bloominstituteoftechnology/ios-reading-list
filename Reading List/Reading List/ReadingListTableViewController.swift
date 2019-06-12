//
//  BooksTableViewController.swift
//  Reading List
//
//  Created by Kat Milton on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {

    // MARK: - Outlets and Properties
    @IBOutlet var readingList: UITableView!
    
    var bookController = BookController()
    
    var sections = ["Read Books", "Unread Books"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistentStore()
//        self.readingList.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readingList.reloadData()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if bookController.books.count < 1 {
            return ""
        } else {
            return self.sections[section]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if bookController.books.count < 1 {
            return 1
        } else {
            return 2
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch (section) {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return bookController.books.count
        }
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        
        guard let bookCell = cell as? BookTableViewCell else { return cell }
        let book = bookFor(indexPath: indexPath)
        bookCell.book = book
        bookCell.delegate = self
    
        return bookCell
    }
    
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = readingList.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenRead(for: book)
        readingList.reloadData()
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
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(remove: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
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
    
    // MARK: - Functions
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBook" {
            guard let readingDetailVC = segue.destination as? BookDetailViewController else { return }
            readingDetailVC.bookController = bookController
        }
        else if segue.identifier == "showBookDetails" {
            guard let readingDetailVC = segue.destination as? BookDetailViewController else { return }
            guard let index = readingList.indexPathForSelectedRow else { return }
            readingDetailVC.bookController = bookController
            readingDetailVC.book = bookFor(indexPath: index)
        
            }
    }
    
    
    

}
