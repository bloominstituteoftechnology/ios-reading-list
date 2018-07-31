//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Conner on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let amountOfReadBooks = bookController.readBooks.count
        let amountOfUnreadBooks = bookController.unreadBooks.count
        
        if section == 0 {
            return amountOfReadBooks
        } else if section == 1 {
            return amountOfUnreadBooks
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)


        return cell
    }
    
    let bookController = BookController()
}
