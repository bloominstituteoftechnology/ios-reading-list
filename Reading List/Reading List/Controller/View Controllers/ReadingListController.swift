//
//  ReadingListController.swift
//  Reading List
//
//  Created by Kenny on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListController: UITableViewController {
    
    let librarian = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        librarian.loadFromPersistentStore()
        BookController.instance.loadFromPersistentStore()
        
        //tableView.reloadData()
        //MARK: Dev/Testing
        //librarian.testSave()
        //librarian.testDelete()
        //librarian.testHasBeenRead()
        //librarian.testUpdateBook()
        //librarian.testReadList()
        //print(librarian.books)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
       tableView.reloadData() //reload view when coming back
    }
    
    override func viewDidAppear(_ animated: Bool) {
         
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return librarian.unreadBooks.count
        } else {
            return librarian.readBooks.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {return UITableViewCell()}
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath) //fixes first time clicked, but now when clicking cell in section 1 if a cell is in section 0, the cell from section 0 becomes checked
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Books To Read"
        } else {
            return "Books I've Read"
        }
    }
    
    //MARK: TableView Helper Methods
    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return librarian.unreadBooks[indexPath.row]
        } else {
            return librarian.readBooks[indexPath.row]
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */
    
    //MARK: TableView Delegate
    //Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            librarian.removeBookFromList(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
            //tableView.reloadData()
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookBtnSegue" {
            if let destination = segue.destination as? DetailViewController {
                destination.librarian = librarian
            }
        } else if segue.identifier == "DetailVCSegue" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            if let destination = segue.destination as? DetailViewController {
                destination.book = self.bookFor(indexPath: indexPath)
                destination.librarian = librarian
            }
        }
    }
}

//MARK: BookTableViewCellDelegate
extension ReadingListController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookCell) {
        //print("toggled")
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        librarian.updateHasBeenRead(for: bookFor(indexPath: indexPath))
        tableView.reloadData()
    }
}
