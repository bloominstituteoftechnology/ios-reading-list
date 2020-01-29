//
//  BookDetailVC.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class BookDetailVC: UIViewController   {

    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
         updateViews()
        bookImageView.contentMode = .scaleAspectFill
        bookImageView.layer.masksToBounds = true
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        saveButton.isEnabled = textField.hasText
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard let title = textField.text,
            let reasonToRead = textView.text,
            title != "" && reasonToRead != "" else { return }
        guard let image = bookImageView.image else { return }
        
        if let book = book {
          
            bookController?.editBook(for: book, with: title, with: reasonToRead, image: image.jpegData(compressionQuality: 1.0)!)
        } else {
            bookController?.createBook(title: title, reason: reasonToRead, image: image.jpegData(compressionQuality: 1.0)!)
        }
        
        navigationController?.popViewController(animated: true)
   
    }
    
    
    func updateViews() {
        guard let book = book else {
            title = "Add a new book"
            return }
        
        title = book.title
        textField.text = book.title
        textView.text = book.reasonToRead
        bookImageView.image = UIImage(data: book.image)
    }
 
    @IBAction func selectBookCover(_ sender: UIButton) {
      showImagePickerControllerActionSheet()
    }
    
    
}
extension BookDetailVC : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func showImagePickerControllerActionSheet() {
        let ac = UIAlertController(title: "Choose your book's cover", message: nil, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: "Choose from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let secondAction = UIAlertAction(title: "Take new photo", style: .default) { (action) in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        ac.addAction(firstAction)
        ac.addAction(secondAction)
        ac.addAction(cancelAction)
        present(ac, animated: true, completion: nil)
    }
    
    
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            bookImageView.image = editedImage
       } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        bookImageView.image = originalImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
}
