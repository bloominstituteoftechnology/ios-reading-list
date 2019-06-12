//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Kat Milton on 6/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Properties And Outlets
    @IBOutlet var bookNameTextField: UITextField!
    @IBOutlet var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateViews()
    }
    

    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if book == nil {
            bookController?.createBook(named: bookNameTextField.text!, withReason: reasonTextView.text)
        } else {
            bookController?.editBookInfo(edit: book!, title: bookNameTextField.text!, reasonToRead: reasonTextView.text)
        }
        self.navigationController?.popViewController(animated: true)
        print(bookController?.books)
    }
    
    // MARK: - Functions
    func updateViews() {
        if book != nil {
            bookNameTextField.text = book?.title
            reasonTextView.text = book?.reasonToRead
            self.title = book?.title
        } else {
            self.title = "Add a new book"
        }
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
