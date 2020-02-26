//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Nichole Davidson on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToRead: UITextView!
    
    var bookController: BookController?
    var bookDetailViewController: BookDetailViewController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if book != nil {
            self.title = bookTitleTextField.text
            let reasonString = String(reasonToRead.text)
            self.reasonToRead.text = reasonString
            bookDetailViewController?.title = "\(bookTitleTextField.text ?? "Add a new book")"
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if book == nil {
            if let bookController = bookController {
                bookController.createBook(with: bookTitleTextField.text ?? "Please fill in title", reasonToRead: reasonToRead.text, hasBeenRead: false)
            }
        } else {
            bookController?.updateBookInfo(with: bookTitleTextField.text ?? "Please fill in title", reasonToRead: reasonToRead.text, hasBeenRead: false)
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
