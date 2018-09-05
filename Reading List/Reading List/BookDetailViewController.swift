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
    @IBOutlet weak var addImageButton: UIButton!
    
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
            imageData = image.pngData()
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
        
        let hapticGenerator = UINotificationFeedbackGenerator()
        hapticGenerator.notificationOccurred(.success)
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Image picker controller delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else { return }
        
        imageView.image = image
        addImageButton.setTitle("Change Image", for: .normal)
    }
    
    // MARK: - Private Utility Methods
    private func updateViews() {
        addImageButton.setTitle("Add Image", for: .normal)
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
            addImageButton.setTitle("Change Image", for: .normal)
        }
        
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
