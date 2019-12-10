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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell }

        // Configure the cell...
        
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book
        return cell
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
            bookC.deleteBook(which: bookC.books[indexPath.row])
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
                if let indexPath = tableView.indexPathForSelectedRow {
                    vc.book =  bookfor(indexPath: indexPath)
                    vc.delegate = self
                }
            }
        default:
            break
        }
    }
}
