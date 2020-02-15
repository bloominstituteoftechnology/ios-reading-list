//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by David Williams on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import  Photos

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var bookcontroller: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    var imagePicker = UIImagePickerController()
    
    func updateViews() {
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        reasonToReadTextField.text = book.reasonToRead
        // check to see if an existing book or a new book for title change
        if bookTitleLabel.text != nil {
            title = book.title
        } else if bookTitleLabel.text == "" {
            title = "Add a book"
        }
    }
   

    @IBAction func saveBookTapped(_ sender: Any) {
        guard let title = bookTitleLabel.text,
            let reason = reasonToReadTextField.text,
            !title.isEmpty,
            !reason.isEmpty else { return }
        if let book = book {
            bookcontroller?.editBook(book: book, title, reason: reason)
        } else {
            bookcontroller?.createBook(named: title, reasonToRead: reason, hasBeenRead: false)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func addCoverImageTapped(_ sender: Any) {
    }
}

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
    }
}
