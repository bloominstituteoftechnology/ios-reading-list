//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Waseem Idelbi on 5/23/22.
//  Copyright © 2022 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
//MARK: - Properties
    var bookController: BookController?
    var book: Book?

//MARK: - IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonsToReadTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
//MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        if let book = book {
            title = book.title
            bookTitleTextField.text = book.title
            reasonsToReadTextView.text = book.reasonToRead
            if let image = book.image?.getImage() {
                imageView.image = image
            }
        } else {
            title = "Add a new book"
        }
    }
    
//MARK: - IBActions
    @IBAction func SaveButtonTapped(_ sender: Any) {
        guard let newTitle = bookTitleTextField.text,
              let newReason = reasonsToReadTextView.text,
              !bookTitleTextField.text!.isEmpty,
              !reasonsToReadTextView.text.isEmpty else { return }
        
        if var book = book {
            bookController?.updateBook(book: &book, newTitle: newTitle, newReasonToRead: newReason, image: imageView.image)
        } else {
            bookController?.newBook(title: newTitle, reasonToRead: newReason, image: imageView.image)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        presentImagePickerController()
    }
    
}

extension BookDetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentImagePickerController() {
        
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("ERROR: The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        imageView.image = image
        picker.dismiss(animated: true)
    }
    
}
