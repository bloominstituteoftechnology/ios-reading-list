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
        title = "Add a book:"
        updateViews()
        imagePicker.delegate = self
    }
    
    var imagePicker = UIImagePickerController()
    
    func updateViews() {
        loadViewIfNeeded()
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        reasonToReadTextField.text = book.reasonToRead
        title = book.title
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
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
}

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        guard let image = info[.originalImage] as? UIImage else { return }
//    }
}
