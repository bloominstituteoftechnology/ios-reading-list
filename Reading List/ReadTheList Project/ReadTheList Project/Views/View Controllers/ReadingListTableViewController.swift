//
//  ReadingListTableViewController.swift
//  ReadTheList Project
//
//  Created by Michael Flowers on 1/17/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    let bookController = BookController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        } else {
            return bookController.unReadBooks.count
        }
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        //you need to implement some logic similar to above where we check the section property on the indexPath to know which section is being either set up in this method call. Since we are going to use this logic in multiple places because of having two sections, we need to make a function
        let book = bookFor(indexPath: indexPath) //Every place you would use bookController.books[indexPath.row] will be replace with this new function
        
        //pass the book to the tableViewCell's book property
        cell.book = book
        
        //set this ViewController to be the delegate
        cell.delegate = self

        return cell
    }
    
    func bookFor(indexPath: IndexPath) -> Book { //This function will facilitate the process of getting the correct instance of Book every time, while also keeping your code clean by not repeating this same logic all over the table view controller subclass.
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unReadBooks[indexPath.row]
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //get the data model to delete
            let bookToDelete = bookFor(indexPath: indexPath)
            
            //now that we have the data model we can delete it from the array
            bookController.delete(book: bookToDelete)
            
            // now that we've deleted it from the array we can delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        //get indexPath
        guard let index = tableView.indexPath(for: cell) else { return }
        
        //now that I have the indexPath can call the bookFor() function
        let book = bookFor(indexPath: index)
        
        //pass the book assocaited with the indexpath into update function
        bookController.updateHasBeenRead(for: book, to: true)
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "cellSelectedSegue" {
            
            //Remember we have to get the model object from the selected row and section. In order to do that we need to get the indexpath for the bookFor function
            //cast sender as a tableViewCell to get the index path
            guard let toDestinationVC = segue.destination as? BookDetailViewController, let index = tableView.indexPath(for: (sender as! UITableViewCell))  else { return }
           
            let book = bookFor(indexPath: index)
            print(book.title)
            print(book.reasonToRead)
            //now that we've checked everything before we pass it into the destination's properties, pass the property
            toDestinationVC.bookController = bookController
            toDestinationVC.book = book
        } else if segue.identifier == "addButtonSegue" {
            guard let toDestinationVC = segue.destination as? BookDetailViewController else { return }
            toDestinationVC.bookController = bookController
        }
        
    }
    

}
