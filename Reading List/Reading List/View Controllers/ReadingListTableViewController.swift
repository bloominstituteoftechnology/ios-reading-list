//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Ian Becker on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        func bookFor(indexPath: IndexPath) {
        }
    }
    
    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        func bookFor(indexPath: IndexPath) -> Book {
            if indexPath.section == 0 {
                return bookController.readBooks[indexPath.row]
            } else {
                return bookController.unreadBooks[indexPath.row]
            }
        }
    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
            cell.delegate = self
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        UITableViewCell.EditingStyle.delete
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            func bookFor(indexPath: IndexPath) -> Book {
            if indexPath.section == 0 {
                return bookController.readBooks[indexPath.row]
            } else {
                return bookController.unreadBooks[indexPath.row]
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addBookSegue" {
            guard let newBookVC = segue.destination as? BookDetailViewController, let indexPath = tableView.indexPathForSelectedRow else { return }
        } else if segue.identifier == "showBookDetailSegue" {
            guard let newBookVC = segue.destination as? 
        }
    }
}
