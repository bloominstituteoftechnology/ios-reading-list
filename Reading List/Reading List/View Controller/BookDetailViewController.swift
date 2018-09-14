//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_22 on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    func updateView(){
        guard isViewLoaded else {return}
        if let book = book {
            navigationController?.title = book.title
            bookTitleLabel.text = book.title
            textView.text = book.reasonToRead
        }else if book == nil{
            navigationController?.title = "Add new book"
        }
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = bookTitleLabel.text,
        let reasonToRead = textView.text
        else {return}
        
        if let book = book{
            bookController?.updateBook(book: book, title: title, reasonToRead: reasonToRead)
        }else{
            bookController?.createBook(title: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    var book: Book?
    var bookController: BookController?
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var textView: UITextView!
}
