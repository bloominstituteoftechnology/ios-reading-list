//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Rob Vance on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextField: UITextView!
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
            updateViews()
           // Do any additional setup after loading the view.
       }
    var bookController: BookController?
    var book: Book?
//    title = "Add a new book"
    
   
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text, let reason = reasonToReadTextField.text
        !title.isEmpty, !reasonToRead.isEmpty else { return }
        
        if let book = book {
            BookController?.editBook
        } else {
            BookController?.createBook(title: title, reasonToRead: reason)
        }
        navigationController? .popViewController(animated: true)
    }
   func updateViews() {
          if book != nil {
              self.title = book?.title
              bookTitleTextField.text = book?.title
              reasonToReadTextField.text = book?.reasonToRead
          } else {
              self.title = "Add a new book"
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
