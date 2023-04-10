//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Harm on 3/21/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        
        if let book = book, let title = titleTextField.text, let reason = reasonToReadTextView.text {
            
            bookController?.updateTitleOrReason(for: book, newTitle: title, newReason: reason)
            
        } else if let title = titleTextField.text, let reason = reasonToReadTextView.text {
        
            bookController?.createBook(title: title, reasonToRead: reason)
            
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        
        titleTextField.text = book?.title
        reasonToReadTextView.text = book != nil ? book?.reasonToRead : "Reason to read: "
        
        self.title = book != nil ? book?.title : "Add a new book"
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
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
