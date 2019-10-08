//
//  ReadingListTableTableViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_201 on 10/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableTableViewController: UITableViewController, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        tableView.reloadData()
    }
    
    
    let bookController = BookController()
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        }else {
            return bookController.unReadBooks[indexPath.row]
        }
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
        if section == 0 {
            return bookController.readBooks.count
        }else {
            return bookController.unReadBooks.count
    }
}
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let readSection = section
        if readSection == 0 {
            return "Read Books"
            
        }else {
            return "Unread Books"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    

}
