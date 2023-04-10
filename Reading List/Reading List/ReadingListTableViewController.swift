//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Harm on 3/17/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
        guard let indexPath: IndexPath = tableView.indexPath(for: cell) else { return }
        
        let cellBook = bookFor(indexPath: indexPath)
        
        bookController.updateHasBeenRead(for: cellBook)
        
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        bookController.loadFromPersistentStore()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return bookController.readBooks.count
        } else if section == 1 {
            return bookController.unreadBooks.count
        }
        
        return 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? BookTableViewCell else { fatalError("cellForRowAt error") }
        
        cell.delegate = self
//        cell.book =
        
        var book: Book? = nil
        if indexPath.section == 0 {
            book = bookController.readBooks[indexPath.row]
        } else if indexPath.section == 1 {
            book = bookController.unreadBooks[indexPath.row]
        } else {
            fatalError("cell for row at")
        }
        
        cell.set(book: book)
        
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
            if indexPath.section == 0 {
                let book = bookController.readBooks[indexPath.row]
                guard let num = bookController.books.firstIndex(of: book) else { fatalError("commit editing style")}
                bookController.books.remove(at: num)
            } else if indexPath.section == 1 {
                let book = bookController.unreadBooks[indexPath.row]
                guard let num = bookController.books.firstIndex(of: book) else { fatalError("commit editing style")}
                bookController.books.remove(at: num)
            } else {
                fatalError("commit editing style")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "You've read these books! :)"
        } else if section == 1 {
            return "You've not read these books :("
        } else {
            return ""
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
        
        if segue.identifier == "DetailViewControllerSegueFromAdd" {
            
            let destVC = segue.destination as? BookDetailViewController
            destVC?.bookController = bookController
            
        } else if segue.identifier == "DetailViewControllerSegueFromCell" {
            
            let destVC = segue.destination as? BookDetailViewController
            destVC?.bookController = bookController
            guard let indexPath = tableView.indexPathForSelectedRow else { fatalError("index path error") }
            destVC?.book = bookFor(indexPath: indexPath)
            
        } else { fatalError("the segue identifier is messed up") }
        
    }
    
}
