//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Jake Connerly on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Read Books"
        case 1:
            return "Unread Books"
        default:
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return bookController.books.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? ReadingListTableViewCell else {return UITableViewCell()}
        let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        
        
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
extension ReadingListTableViewController: ReadingListTableViewCellDelegate {
    func toggleHasBeenRead(for cell: ReadingListTableViewCell) {
        guard let book = cell.book,
            let indexPath = tableView.indexPath(for: cell) else { return }
        bookController.updateHasBeenRead(for: book)
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
    
}
