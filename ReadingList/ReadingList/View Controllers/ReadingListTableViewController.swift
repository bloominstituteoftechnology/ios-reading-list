//
//  ReadingListTableViewController.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    // MARK: - Properties
    let bookController = BookController()
    let book: Book?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let book: Book
        if section = 0 {
            book = bookController.readBooks[indexPath.row]
        } else {
            book = bookController.unreadBooks[indexPath.row]
        }
        
        

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
