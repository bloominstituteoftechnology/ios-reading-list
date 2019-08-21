//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var reasonTextField: UITextView!
    
    var bookController = BookController()
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else {
            self.title = "Add New Book"
            return
        }
        nameLabel.text = book.title
        reasonTextField.text = book.reasonToRead
        self.title = book.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveBook(_ sender: UIButton) {
        if let name = nameLabel.text, let reason = reasonTextField.text {
            if book == nil {
                bookController.createBook(title: name, reasonToRead: reason)
            } else {
                guard let book = book else { return }
                bookController.setTitleReasonToRead(bookToUpdate: book, name, reason)
            }
            navigationController?.popViewController(animated: true)
        }
    }
}

