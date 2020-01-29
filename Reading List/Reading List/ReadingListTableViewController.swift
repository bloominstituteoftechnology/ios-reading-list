//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

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

        if section == 0{
        return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }

        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Read"
        }
        if section == 1{
            return "Unread"
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle = .delete, forRowAt indexPath: IndexPath) {
        bookController.books.remove(at: indexPath.row)
        tableView.reloadData()
        
        
    }
    
     private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    

    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditBookSegue"{
            guard let indexPath = tableView.indexPathForSelectedRow,
                let editBookDetailVC = segue.destination as? BookDetailViewController else {return}
            let book = bookFor(indexPath: indexPath)
            editBookDetailVC.book = book
//            editBookDetailVC.bookController = bookController
        
        }

        else if segue.identifier == "AddBookSegue"{
               if let addBookDetailVC = segue.destination as? BookDetailViewController{
                addBookDetailVC.bookController = bookController
                   
               }
               }
    }


}

extension ReadingListTableViewController: BookTableViewCellDelegate{
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    
}
