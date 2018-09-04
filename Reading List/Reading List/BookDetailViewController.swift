//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dillon McElhinney on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Properties
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }

    // MARK: - UI Methods
    @IBAction func addImage(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveBook(_ sender: UIBarButtonItem) {
        //Unwrap the text fields and views and make sure the required ones have content.
        guard let title = titleTextField.text, !title.isEmpty,
            let reasonToRead = reasonToReadTextField.text else { return }
        
        //If there is an image picked, represent it as Data, else pass nil
        let imageData: Data?
        if let image = imageView.image {
            imageData = UIImagePNGRepresentation(image)
        } else {
            imageData = nil
        }
        
        if let book = book {
            //Update the current book
            bookController?.update(book, title: title, reasonToRead: reasonToRead, imageData: imageData)
        } else {
            //Create a new book
            bookController?.createBook(title: title, reasonToRead: reasonToRead, imageData: imageData)
        }
        
        //Pop the view off of the stack
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Image picker controller delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        imageView.image = image
    }
    
    // MARK: - Private Utility Methods
    private func updateViews() {
        //If there is no book, the user is adding a new one
        guard let book = book else {
            title = "Add a new book"
            return
        }
        
        //If there is a book, update the UI to reflect its properties
        title = book.title
        titleTextField.text = book.title
        reasonToReadTextField.text = book.reasonToRead
        if let imageData = book.imageData {
            imageView.image = UIImage(data: imageData)
        }
        
    }
    
}
