//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by LaFleur on 12/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
        
        let bookController = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
        
        
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "AddBookSegue" {
                if let addBookVC = segue.destination as? BookDetailViewController {
                    
                }
            }
        }
        
        
        
        
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return bookController.books.count
        }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
            
            let book = bookController.books[indexPath.row]
            cell.book = book
            
            return cell
        }
    }

