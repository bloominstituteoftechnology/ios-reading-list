//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Mark Poggi on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    // Add a `bookController` constant, and set its value to a new instance of `BookController`.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    // Adopt the `BookTableViewCellDelegate` protocol, and add the `toggleHasBeenRead(for cell: ...)` function. The function should call the `BookController`'s `updateHasBeenRead(for: Book)` method. You will need an instance of `Book` to pass in to this function.  At the end of this function, reload the table view.
    //- **HINT:** Think about how to get an `IndexPath` using the cell parameter of the `toggleHasBeenRead(for cell: ...)`.
    
    func toggleHasBeenReadFor(cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        let book = bookFor(indexPath: indexPath)
        
        bookController.updateHasBeenRead(for: book)
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    // mplement the `numberOfSections(in tableView: ...)`. It should already be in the table view subclass above the `numberOfRowsInSection`. If you've deleted it, simply call it again. This method is very similar to the `numberOfRowsInSection`. It simply wants you to return an `Int` indicating how many sections the table view should have. In this case, **we simply want to return two.**
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Implement the `numberOfRowsInSection` next. This time however, since we are using multiple sections, we can't get away with simply returning the `count` of the `books` array, because that holds all of the books in the application. We need to now say, "For my first section (that will display only the **read** books), return the number of read books, and for the second section return the number of unread books." Since the section that the table view is trying to get the number of rows for is passed in as a parameter, we can easily check the section using a conditional statement, and return the correct amount. Use the `readBooks` and `unreadBooks` computed properties in the `bookController` to get the right amount of rows depending on the section. The first section (0) will show the read books, and the second section (1) will show the unread books.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count }
        else {
            return bookController.unreadBooks.count
        }
    }
    
    /*
     However since we have multiple sections, you need to implement some logic similar to that in step 3 where we check the `section` property on the `indexPath` to know which section is being either set up in the `cellForRowAt`, edited in the `commit editingStyle`, etc. **and then** we can use the `indexPath.row` to pull the correct instance of the model object from the correct array. For example, if the user swipes and deletes the second cell in the first section, we need to look in the `readBooks` array because that is the data source for that section. If the cell that was being deleted in the second section, we would use the `unreadBooks` array instead.
     
     Since you will need to use this logic in multiple places in this table view controller, make a function that will do that logic for you so you don't have to re-write this logic over and over throughout this class. Call the function `func bookFor(indexPath: IndexPath) -> Book`. Try to write it on your own, however you may use the the example function that is hidden right now below:
     */
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    //  Fill out the `cellForRowAt` function, making sure to set the cell's `delegate` property, or else the delegate relationship between the table view controller and the custom cell will not exist.
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        let book = bookFor(indexPath: indexPath)
        
        cell.book = book
        
        return cell
        
    }
    
    // Fill out the `commit editingStyle` function. You only need to worry about the `.delete` case.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            
            bookController.delete(book: book)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Fill out the `titleForHeaderInSection` function, giving each section a unique title. Another function that we can use to help the user know why we have split the data up into sections is the `titleForHeaderInSection` method. This is also a part of the `UITableViewDataSource` protocol. It allows you to return a string that will be put in the header of a section. Similar to the `numberOfRowsInSection` method, you will need to check the `section` parameter of the function, and return a string depending on its value. For example, the title of the first section (0) could be "Read Books" and the title of the second section could be "Unread Books". 
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            guard bookController.readBooks.count > 0 else {return nil}
            return "Read Books"
        } else {
            guard bookController.unreadBooks.count > 0 else {return nil}
            return "Unread Books"
        }
    }
    
    // MARK: - Navigation
    
    /* Finally, we need to set up the `prepare(for segue: ...)` in order to pass the `bookController` and potentially a `Book` to the `BookDetailViewController`.
     
     1. Check the segue's `identifier` property using a conditional statement. If it's the one from the "Add" bar button item, then this means the user wants to create a new `Book`. Pass the `bookController` variable in the table view controller to the segue's destination view controller. (You will need to cast the destination as the correctly typed view controller)
     2. If the segue's identifier matches the cell's segue identifier, do the same thing as step 1, and also pass a `Book` object that was selected in the table view to the destination view controller's `book` property as well.
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AddBook" {
            
            guard let destinationVC = segue.destination as? BookDetailViewController else { return }
            
            destinationVC.bookController = bookController
            
        } else if segue.identifier == "ViewBook" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? BookDetailViewController else { return }
            
            let book = bookFor(indexPath: indexPath)
            
            destinationVC.book = book
            destinationVC.bookController = bookController
        }
    }
    
    var bookController = BookController()
}



