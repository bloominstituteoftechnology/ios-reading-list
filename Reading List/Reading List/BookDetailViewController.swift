//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jason Modisett on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveBook(_ sender: Any) {
        guard let bookController = bookController,
              let title = bookTitleTextField.text,
              let reasonToRead = reasonForReadingTextField.text else { return }
        
        if title == "" || reasonToRead == "" { return }
        
        if title != book?.title || reasonToRead != book?.reasonToRead {
            bookController.createBook(with: title, reasonToRead: reasonToRead)
        }
        
        let hapticGenerator = UINotificationFeedbackGenerator()
        hapticGenerator.notificationOccurred(.success)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        
        title = book.title
        
        bookTitleTextField.text = book.title
        reasonForReadingTextField.text = book.reasonToRead
    }

    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonForReadingTextField: UITextField!
    
}
