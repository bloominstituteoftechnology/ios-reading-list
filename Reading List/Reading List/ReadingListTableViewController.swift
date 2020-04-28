//
//  TableViewController.swift
//  Reading List
//
//  Created by Ian French on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    
 

    
    
    let bookController = BookController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.reloadData()
        
        bookController.loadFromPersistentStore()
        

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.unreadBooks.count
        } else if section == 1 {
            return bookController.readBooks.count
        
        }
        return 0
    }

     func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.unreadBooks[indexPath.row]
        } else {
            return bookController.readBooks[indexPath.row]
        }
    }



 
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            let deletedBook = bookFor(indexPath: indexPath)
            bookController.deleteBook(with: deletedBook)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
      
        }
        tableView.reloadData()
    }

    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell()}
    cell.delegate = self
    let book = bookFor(indexPath: indexPath)
    cell.book = book
    return cell
    
    
    }
    
    
    
    
    
    
    
    
    
    

       override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          if section == 0 {
            return "Read Books"
           } else {
            return "Unread Books"
         }
     }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
               if segue.identifier == "addSegue" {
                   if let addBookVC = segue.destination as? BookDetailViewController {
                    addBookVC.bookController = bookController
                   }
               } else if segue.identifier == "detailViewSegue" {
                   if let editBookVC = segue.destination as? BookDetailViewController {
                       if let indexPath = tableView.indexPathForSelectedRow {
                           let book = bookFor(indexPath: indexPath)
                           editBookVC.bookController = bookController
                           editBookVC.book = book
    
                       }
                   }
               }
    
          }
    
    
    
    
    
  

}
extension  ReadingListTableViewController: BookTableViewCellDelegate {
func toggleHasBeenRead(for cell: BookTableViewCell) {
     
     if let indexPath = tableView.indexPath(for: cell) {
         let book = bookFor(indexPath: indexPath)
         bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
         
     }
  }
}
