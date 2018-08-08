//
//  DetailViewController.swift
//  Reading List
//
//  Created by Iyin Raphael on 8/7/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        updateViews()

        // Do any additional setup after loading the view.
    }
    var bookController: BookController?
    var book: Book?
    
    func updateViews(){
        guard isViewLoaded else {return}
        if let book = book{
            navigationController?.title = book.title
            bookTitleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
        }else{
            navigationController?.title = "add new book"
        }
    }

    @IBAction func Send(_ sender: Any) {
        guard let title = bookTitleTextField.text, let reasonToRead = reasonToReadTextView.text else {return}
        
        if let book = book {
            bookController?.updateTitleandRead(book: book, title: title, reasonToRead: reasonToRead)
        }else{
            
            bookController?.create(title: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
}
