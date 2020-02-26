//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Shawn James on 2/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - Properties
    var bookController: BookController?
    var book: Book?
    
    // MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func updateViews() {
        if let book = book {
            title = book.title
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
        }
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let title = titleTextField.text else { return }
        guard let reason = reasonTextView.text else { return }
        
        
        if let book = book {
            bookController?.updateText(for: book, title: title, reasonToRead: reason)
        } else {
            bookController?.create(title: title, reasonToRead: reason)
            
        }
    }
    
    
    
}
