//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonsTextView: UITextView!
    @IBOutlet weak var bookCover: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    var bookController: BookController?
    var book: Book?
    var delegate: DetailViewDelegate?
    
    
    override func viewDidLoad() {
        updateViews()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if var book = book {
            titleTextField.text = book.title
            reasonsTextView.text = book.reasonToRead
            bookCover.image = book.image?.getImage()
            self.title = book.title
        } else {
            self.title = "Add a new book"
        }
    }
    
    @IBAction func coverTapped(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            bookCover.image = pickedImage
            
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
        let reasons = reasonsTextView.text,
        let bookController = bookController else { return }
        
        if let book = book {
            bookController.update(for: book, title: title, reasonToRead: reasons, image: Image(withImage: bookCover.image!))
            print("Old file edited")
        } else {
            bookController.create(title: title, reasonToRead: reasons, image: Image(withImage: bookCover.image!))
            print("New file added")
        }
        super.navigationController?.popViewController(animated: true)
        delegate?.updateView()
        
    }
}
