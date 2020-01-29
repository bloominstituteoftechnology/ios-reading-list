//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Keri Levesque on 1/28/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
  
    @IBOutlet weak var textView: UITextView!
   
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
        
    }
    
    func updateViews() {
           if (book == nil) {
               self.title = "Add a new book"
           } else {
               self.title = book?.title
               textField.text = book?.title
               textView.text = book?.reasonToRead
           }
       }

    
    
    @IBAction func saveButton(_ sender: Any) {
        if let book = book {
                guard let titleReady = textField.text, let reasonReady = textView.text else { return }
                bookController?.editBook(book: book, title: titleReady, reasonToRead: reasonReady)
                        } else {
                guard let titleReady = textField.text, let reasonReady = textView.text else { return }
                bookController?.createBook(named: titleReady, withReason: reasonReady)
                }
            navigationController?.popViewController(animated: true)
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


