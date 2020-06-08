//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Gladymir Philippe on 6/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    
    
    @IBOutlet weak var bookTitle: UITextField!
    
    @IBOutlet weak var reasonToRead: UITextView!
    
    var book: Book? {
        didSet {
       //     updateViews()
        }
    }
    
    private func updateViews() {
      //  guard let book = book else { return }
        
        if let book = book {
            bookTitle.text = book.title
            reasonToRead.text = book.reasonToRead
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveTappedButton(_ sender: Any) {
        guard let title = bookTitle.text, let reasonToRead = reasonToRead.text else {
            return
        }
        if let book = book {
            bookController?.updateBook(book: book, title: title, reasonToRead: reasonToRead)
        } else {
             bookController?.createBook(title: title, reasonToRead: reasonToRead)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
    }


}
