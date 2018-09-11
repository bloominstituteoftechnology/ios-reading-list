//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_22 on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else {return}
        let book = self.bookFor(indexPath: index)
        bookController.updateHasBeenRead(for: book)
    }
    
    weak var delegate: BookTableViewCellDelegate?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

  

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
       let book = self.bookFor(indexPath: indexPath)
        cell.delegate = self
        return cell
    }

  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = self.bookFor(indexPath: indexPath)
            bookController.delete(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        }else{
            return "Unread Books"
        }
    }
    



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
    
    func bookFor(indexPath: IndexPath) -> Book{
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        }else{
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    let bookController = BookController()

}
