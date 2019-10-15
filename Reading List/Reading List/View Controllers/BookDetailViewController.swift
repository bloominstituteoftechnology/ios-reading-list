//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

protocol BookDetailDelegate {
    func updateViews()
}

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    var delegate: BookDetailDelegate?
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var reasonToReadView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateViews()
    }

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        saveBook()
    }
    
    private func saveBook() {
        guard let newTitle = titleField.text,
            let newReasonToRead = reasonToReadView.text
            else { return }
        
        if let updatingBook = book {
            bookController?.update(book: updatingBook, titleTo: newTitle, reasonTo: newReasonToRead)
        } else {
            bookController?.createBook(called: newTitle, for: newReasonToRead, haveRead: false)
        }
        
        navigationController?.popToRootViewController(animated: true)
        delegate?.updateViews()
    }
    
    private func updateViews() {
        if let book = book {
            self.title = book.title
            self.navigationItem.title = book.title
            titleField.text = book.title
            reasonToReadView.text = book.reasonToRead
        } else {
            let title = "Add a new book"
            self.title = title
            self.navigationItem.title = title
        }
    }
    
}

