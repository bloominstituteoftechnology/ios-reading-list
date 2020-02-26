//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Bradley Diroff on 2/25/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet var titleField: UITextField!
    
    @IBOutlet var reasonTextView: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let newBook = book {
            bookController?.updateTitleOrReasson(with: newBook, title: newBook.title, reason: newBook.reasonToRead)
        } else {
            guard let title = titleField.text, let reason = reasonTextView.text else {return}
            bookController?.createBook(with: title, reason: reason)
        }
    }
    
    func updateViews() {
        guard let book = book else {
            navigationItem.title = "Add a new book"
            return
        }
        
        navigationItem.title = book.title
        titleField.text = book.title
        reasonTextView.text = book.reasonToRead
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
