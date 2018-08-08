//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Iyin Raphael on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit



class ReadingLIstTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookController.loadFromPersistence()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    weak var delegate: BookTableViewCellDelegate?
    
    func toggleHasBeenRead(for cell: ReadingListTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else {return}
        let book = bookFor(indexPath: index)
        bookController.updateHasBeenRead(book: book)
        tableView.reloadData()
    }
    
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        }else{
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read"
        }
        if section == 1{
            return "Un-Read"
        }
        return "Error"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.readBooks.count
        }else{
            return bookController.unreadBooks.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? ReadingListTableViewCell else {return UITableViewCell()}
        
        let book = bookFor(indexPath: indexPath)
        cell.delegate = self
        cell.book = book
        
        
        return cell
    }
    
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let detailVC = segue.destination as? DetailViewController else {return}
            let book = bookFor(indexPath: indexPath)
            detailVC.bookController = bookController
            detailVC.book = book
        }
        
        if segue.identifier == "addVC"{
            guard let detailVC = segue.destination as? DetailViewController else {return}
            detailVC.bookController = bookController
        }
    }
    
    
}
