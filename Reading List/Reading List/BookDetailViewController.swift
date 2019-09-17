//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by admin on 9/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    var bookController: BookController?
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    func updateViews() {
        if let aBook = book {
            bookTitleTextField.text = aBook.title
            reasonToReadTextView.text = aBook.reasonToRead
            
        }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let title = bookTitleTextField.text, !title.isEmpty,
            let reason = reasonToReadTextView.text, !reason.isEmpty else { return }
        bookController?.createBook(named: title, reasonToRead: reason, hasBeenRead: false)
        bookController?.saveToPersistentStore()
        navigationController?.popViewController(animated: true)
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
