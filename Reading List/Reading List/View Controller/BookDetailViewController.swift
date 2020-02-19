//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_259 on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    // MARK: IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        
        let testBook = bookController?.createBook(title: titleTextField.text ?? "", reasonToRead: reasonTextView.text ?? "")
            print(testBook)
        self.navigationController?.popToRootViewController(animated: true)
//        print("Save Tapped #1")
//        if let book = book, !book.title.isEmpty {
//            print("Save Tapped 3")
//            bookController?.updateBook(for: book, newTitle: titleTextField.text, newReason: reasonTextView.text)
//            print("Save Tapped")
//            self.dismiss(animated: true)
//        } else if let title = titleTextField.text, !title.isEmpty {
//            print("Save Tapped4")
//        } else {
//            print("Save Tapped 2")
//            self.dismiss(animated: true)
//        }
    }
    
    // MARK: Properties
    
    var bookController: BookController?
    var book: Book?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if let book = book, !book.title.isEmpty {
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            navigationItem.title = book.title
        } else {
            navigationItem.title = "Add a new book"
        }
    }

}
