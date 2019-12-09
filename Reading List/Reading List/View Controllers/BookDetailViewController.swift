//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by David Wright on 12/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
   
    var bookController: BookController?
    var book: Book?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    // MARK: - IBActions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text,
        let reasonToRead = reasonToReadTextView.text,
        !title.isEmpty,
        !reasonToRead.isEmpty,
        let bc = bookController else { return }
        
        if let book = book {
            bc.updateProperties(for: book, newTitle: title, newReasonToRead: reasonToRead)
        } else {
            guard !bc.books.contains(Book(title: title, reasonToRead: reasonToRead)) else { return }
            bc.createBook(withTitle: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if let book = book {
            self.title = book.title
            titleTextField.text = book.title
            reasonToReadTextView.text = book.reasonToRead
        } else {
            self.title = "Add a new book"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
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
