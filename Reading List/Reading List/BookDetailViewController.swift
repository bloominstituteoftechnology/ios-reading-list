//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by David Williams on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit
import  Photos

class BookDetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editBookCoverLabel: UIButton!
    
    @IBOutlet weak var editBookLabel: UILabel!
    
    var bookcontroller: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add the book:"
        updateViews()
        imagePicker.delegate = self
    }
    
    var imagePicker = UIImagePickerController()
    
    func updateViews() {
        loadViewIfNeeded()
        guard let book = book else { return }
        bookTitleLabel.text = book.title
        reasonToReadTextField.text = book.reasonToRead
        editBookCoverLabel.setTitle("Update Cover Image", for: [])
        editBookLabel.text = "Edit a Book"
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
#warning("Why does this not work?")
extension BookDetailViewController {

//    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            imageView.image = image
//        }
//        picker.dismiss(animated: true, completion: nil)
//    }
}

extension BookDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text,
            !text.isEmpty else { return false }
        print("\(String(describing: textField.text))")
        switch textField {
        case bookTitleLabel:
            reasonToReadTextField.textInputView.resignFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
