//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Morgan Smith on 12/9/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
       var book: Book?

    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var reasonText: UITextView!
    
    @IBAction func saveButton(_ sender: Any) {
        if let book = book {
            bookController?.updateBookProperties(book: book, newTitle: titleText.text, newReasonToRead: reasonText.text)
        } else {
            bookController?.Create(title: titleText.text!, reasonToRead: reasonText.text)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    private func updateViews() {
        if let book = book {
            titleText.text = book.title
            reasonText.text = book.reasonToRead
            self.title = book.title
        } else {
            self.title = "Add a new Book"
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
