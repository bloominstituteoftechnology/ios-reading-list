//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by macbook on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        
        // TODO: - Double Check. In the action of the button, it should either call the createBook method in the bookController if the book property is nil or call the update method in the bookController if the book property is not nil.
        if book == nil {
            bookController?.createBook(title: titleTextField.text!, reasonToRead: reasonTextView.text)
        } else {
            bookController?.updateHasBeenRead(for: book!)
            
        }
    }
    
    
    func  updateViews() {
        
        // TODO: - It should also set the title of the view controller to the book's title if there is one, or it should set the title to "Add a new book" if a new book is going to be created.
        if let book = book {
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
            
            //self.viewController.title
        }
        
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
