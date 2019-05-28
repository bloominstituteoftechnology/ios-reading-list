//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Mitchell Budge on 5/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonsTextView: UITextView!
    @IBAction func saveButtonPressed(_ sender: Any) {
        if book == nil {
            bookController!.createBook(title: bookTitleTextField.text!, reasonToRead: reasonsTextView.text)
        }   else if book != nil {
            updateViews()
        }
    }
    
    var bookController: BookController?
    var book: Book?
    
    func updateViews() {
        guard let bookTitle = book?.title else { return }
        bookTitleTextField.text = bookTitle
        guard let reasons = book?.title else { return }
        reasonsTextView.text = reasons
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
