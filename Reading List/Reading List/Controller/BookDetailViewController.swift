//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by LambdaSchoolVM_Catalina on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
// ib outlets
    
    @IBOutlet weak var bookTitleTxtField: UITextField!
    @IBOutlet weak var reasonsToReadTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        guard let book = book else {
        title = "Add a new Book"
        return }
        
        title = book.title
        bookTitleTxtField.text = book.title
        reasonsToReadTxtView.text = "\(book.reasonToRead)"
        
    }
    

  // ib actions
    @IBAction func saveBtnWasPressed(_ sender: UIBarButtonItem) {
        guard let title = bookTitleTxtField.text,
            let reasonToRead = reasonsToReadTxtView.text,
            !title.isEmpty,
            !reasonToRead.isEmpty else { return }
        
        //create a new book
        bookController?.createBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
        navigationController?.popViewController(animated: true) //dismiss after saving
        
        //update existing book
        
        
    }
    
}
