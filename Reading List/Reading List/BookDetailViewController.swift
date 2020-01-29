//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Chris Gonzales on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var movieTitleTextField: UITextField!
    @IBOutlet weak var reasonToSeeTextView: UITextView!
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let title = movieTitleTextField.text else {return}
        guard let reason = reasonToSeeTextView.text else {return}
        if let book = book{
            bookController?.editBookInformation(for: book)
        } else {
            bookController?.createListEntry(with: title, reasonToRead: reason)
        }
        navigationController?.popViewController(animated: true)
        }
    
    func updateViews(){
        guard let book = book  else {return}
        movieTitleTextField.text = book.title
        reasonToSeeTextView.text = book.reasonToRead
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
updateViews()
        // Do any additional setup after loading the view.
    }
    
}
