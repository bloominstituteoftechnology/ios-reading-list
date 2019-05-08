//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_64 on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    let bookController = BookController()
    
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

 
    
    
    
    
}
