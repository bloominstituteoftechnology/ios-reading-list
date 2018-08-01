//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Carolyn Lea on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController
{
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController = BookController()
    var book: Book?
    
    override func viewWillAppear(_ animated: Bool)
    {
        updateViews()
    }

    
    @IBAction func save(_ sender: Any)
    {
        if book == nil
        {
            guard let title = titleTextField.text,
                let reasonToRead = reasonTextView.text else {return}
            bookController.createBook(title: title, reasonToRead: reasonToRead)
            print(title)
            print(reasonToRead)
            navigationController?.popViewController(animated: true)
        }
        else
        {
            
            guard let title = titleTextField.text,
                let reasonToRead = reasonTextView.text else {return}
            bookController.updateBook(book: book!, title: title, reasonToRead: reasonToRead)
        }
        
    }
    
    func updateViews()
    {
        if book != nil
        {
            titleTextField.text = book?.title
            reasonTextView.text = book?.reasonToRead
            title = book?.title
        }
        else
        {
            title = "Add A New Book"
        }
        
        
    }
    
    

}
