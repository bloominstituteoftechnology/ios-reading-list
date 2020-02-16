//
//  DetailViewController.swift
//  Reading List
//
//  Created by Matthew Martindale on 2/15/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

protocol BookWasAdded {
    func updateTableView()
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var delegate: BookTableViewCellDelegate?
    var bookController = BookController()
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    @IBAction func saveBookButtonTapped(_ sender: Any) {
        if book != nil {
            bookController.updateTitleAndReasonToRead(for: book!)
        } else {
            guard let title = TitleTextField.text,
                let reasonToRead = reasonToReadTextView.text else { return }
            bookController.createBook(title: title, reasonToRead: reasonToRead, hasBeenRead: false)
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        if book != nil {
            TitleTextField.text = book?.title
            reasonToReadTextView.text = book?.reasonToRead
            self.title = book?.title
        } else {
            self.title = "Add a new Book"
        }
    }
}
