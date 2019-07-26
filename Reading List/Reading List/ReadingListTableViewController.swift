//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by brian vilchez on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    var bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return bookController.books.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return bookController.books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
            let book = bookController.books[indexPath.row]
        cell.nameLabel.text = book.title
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBookDetailSegue" {
            guard let addBookVC = segue.destination as? AddBookViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        let book = bookController.books[indexPath.row]
            addBookVC.book = book
            addBookVC.bookController = bookController
        
        } else if segue.identifier == "AddBookShowSegue" {
            guard let addBookVC = segue.destination as? AddBookViewController
                else {return}
            addBookVC.bookController = bookController
        }
        
    }


}
