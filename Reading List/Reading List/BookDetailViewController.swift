//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by admin on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    

    var bookController: BookController?
    var book: Book?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if book == nil {
            bookController?.createBook(titled: <#T##String#>, withReasonRead: <#T##String#>, withHasBeenRead: <#T##Bool#>)
        } else {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let book = book else { return }
        
        if book.title == book.title {
            bookTitleTextField.text = book.title
        } else {
            bookTitleTextField.text = "Add a new book"
        }
        reasonToReadTextField.text = "Reason to read: \(book.reasonToRead)"
        
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
