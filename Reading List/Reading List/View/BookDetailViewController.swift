//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var book: Book?
    var delegate: manageBookDelegate?
    
    func updateViews () {
        guard let book = book else { return }
        titleTextField.text = book.title
        reasonTextView.text = book.reasonToRead
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            let reason = reasonTextView.text,
            !title.isEmpty,
            !reason.isEmpty else {return}
        if let book = book {
            delegate?.updateBook(book: book, title: title, reason: reason)
            navigationController?.popViewController(animated: true)
        } else {
            delegate?.createBook(title: title, reason: reason)
            dismiss(animated: true, completion: nil)
        }
        
    }
}
