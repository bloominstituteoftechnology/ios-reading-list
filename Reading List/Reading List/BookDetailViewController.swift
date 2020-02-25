//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Wyatt Harrell on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveBookButtonTapped(_ sender: Any) {
        
        if book == nil {
            guard let title = titleTextField.text, !title.isEmpty, let reason = reasonToReadTextView.text, !reason.isEmpty else { return }
            bookController?.create(title: title, reasonToRead: reason)
            print("test")
            
        } else if book != nil {
            guard let book = book else {return}
             guard let title = titleTextField.text, !title.isEmpty, let reason = reasonToReadTextView.text, !reason.isEmpty else { return }
            bookController?.updateBook(for: book, title: title, reason: reason)
        }
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
    }
    
    
    func updateViews() {
        titleTextField.text = book?.title
        reasonToReadTextView.text = book?.reasonToRead
        self.navigationItem.title = book?.title
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
