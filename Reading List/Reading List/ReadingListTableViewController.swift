//
//  BooksTableViewController.swift
//  Reading List
//
//  Created by morse on 4/29/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
//    @IBOutlet var bookNameLabel: UILabel!
//    @IBOutlet var bookReadButton: UIButton!
    
    
    
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
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell 
//        guard let bookCell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        bookCell.delegate = self
        let book = bookFor(indexPath: indexPath)
        bookCell.book = book
        
        return bookCell
     }
 
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(of: bookFor(indexPath: indexPath))
        
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
            bookController.deleteBook(book: book)
            
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        if segue.identifier == "AddBookSegue" {
            guard let addBookVC = segue.destination as? BookDetailViewController else { return }
            addBookVC.bookController = bookController
        } else if segue.identifier == "BookDetailSegue" {
            guard let bookDetailVC = segue.destination as? BookDetailViewController else { return }
            guard let cell = sender as? BookTableViewCell else { return }
            bookDetailVC.bookController = bookController
            bookDetailVC.book = cell.book
        }
        // Pass the selected object to the new view controller.
    }
 

}
