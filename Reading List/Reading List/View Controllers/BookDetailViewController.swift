//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_204 on 10/15/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

protocol BookDetailViewDelegate {
    func addOrEditBook()
}

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    var delegate: BookDetailViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViews()
    }
    
    func updateViews() {
        if (book == nil) {
            self.title = "Add a new book"
        } else {
            self.title = book?.title
            bookTextField.text = book?.title
            reasonToReadTextView.text = book?.reasonToRead
        }
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if (book == nil) {
            guard let bookController = bookController,
                let bookText = bookTextField.text,
                !bookText.isEmpty else { return }
            
            bookController.createBook(titleOf: bookText, reason: reasonToReadTextView.text, hasRead: false)
            delegate?.addOrEditBook()
        } else {
            guard let bookController = bookController,
                let book = book,
                let bookText = bookTextField.text,
                !bookText.isEmpty else { return }
            
            bookController.updateHasBeenRead(for: book)
            bookController.updateTitleAndReason(for: book)
            delegate?.addOrEditBook()
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
