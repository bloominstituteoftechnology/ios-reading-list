//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Nonye on 4/21/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {//BookTableViewCellDelegate {
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.dataSource = self
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 0
        }
    
//    override func 

    }
    
    
//MARK: NOT UNDERSTANDING WHY IT CANT READ MY READ AND UNREAD BOOKS. CANT MOVE ON, ASK 4 HELP.
//    func bookFor(indexPath: IndexPath) ->  Book {
//        if indexPath == 0
//        return BookController.read
//    }
    
    

