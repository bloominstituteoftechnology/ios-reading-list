//
//  DetailViewController.swift
//  Reading List
//
//  Created by Spencer Curtis on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    
    
    var librarian: BookController?
    var book: Book?
    
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        print("save Tapped")
        if let book = book {
            print("updating book")
            guard let title = textField.text,
                let reasonText = textView.text else {return}
            print("setting text")
            librarian?.updateBook(book: book, title: title, reasonToRead: reasonText)
            self.dismiss(animated: true, completion: nil)
        } else {
            guard let title = textField.text,
                let reasonText = textView.text else {return}
            print("adding book")
            librarian?.addBookToRead(title: title, reasonToRead: reasonText)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Helper Methods
    func updateViews() {
        guard let book = book else {return}
        self.textField.text = book.title
        self.textView.text = book.reasonToRead
    }
}

