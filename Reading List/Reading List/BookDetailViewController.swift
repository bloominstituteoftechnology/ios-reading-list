//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Hunter Oppel on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    func updateViews() {
        if let book = book {
            self.navigationController?.title = book.title
            nameTextField.text = book.title
            reasonTextView.text = book.reasonToRead
        } else {
            self.navigationController?.title = "Add a new book"
            nameTextField.text = ""
            reasonTextView.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateViews()
    }
    
    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text,
            let reason = reasonTextView.text else { return }
        
        if let book = book {
            bookController?.updateText(for: book, newTitle: name, newReason: reason)
        } else {
            bookController?.createBook(title: name, reasonToRead: reason)
        }
        
        self.navigationController?.popViewController(animated: true)
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
