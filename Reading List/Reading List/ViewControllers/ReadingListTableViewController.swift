//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Carolyn Lea on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate
{
    let bookController = BookController()
    //var book: Book?
    
    
    
    func toggleHasBeenRead(for cell: BookTableViewCell)
    {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
        
    }
    

    override func viewWillAppear(_ animated: Bool)
    {
        bookController.loadFromPersistentStore()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section == 0
        {
            return bookController.readBooks.count
        }
        else
        {
            return bookController.unreadBooks.count
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! BookTableViewCell

        let book = bookFor(indexPath: indexPath)
//        let book = bookController.books[indexPath.row]
        cell.book = book
        cell.delegate = self
        cell.bookTitleLabel.text = book.title
        if book.hasBeenRead
        {
            cell.checkBoxButton.imageView?.image = UIImage(named:"checked")
        }
        else
        {
            cell.checkBoxButton.imageView?.image = UIImage(named: "unchecked")
        }
        

        return cell
    }
    
    
    private func bookFor(indexPath: IndexPath) -> Book
    {
        if indexPath.section == 0
        {
            return bookController.readBooks[indexPath.row]
        }
        else
        {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let book = bookFor(indexPath: indexPath)
            //let book = bookController.books[indexPath.row]
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0
        {
            if bookController.readBooks.count > 0
            {
                return "Books Read"
            }
        }
            
        if section == 1
        {
            if bookController.unreadBooks.count > 0
            {
                return "Books Unread"
            }
        }
        return "Add some books"
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ToAddBookView"
        {
            guard let addView = segue.destination as? BookDetailViewController else {return}
            addView.bookController = bookController
        }
        else if segue.identifier == "ToEditBookView"
        {
            guard let editView = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            editView.bookController = bookController
            editView.book = bookController.books[indexPath.row]
            
        }
    }
    

    
    
    
    
    
    
    
    
    
}
