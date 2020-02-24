//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Karen Rodriguez on 2/23/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonsTextView: UITextView!
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
        let reasons = reasonsTextView.text,
        let bookController = bookController else { return }
        
        if let book = book {
            bookController.update(for: book, title: title, reasonToRead: reasons)
            print("Old file edited")
        } else {
            bookController.create(title: title, reasonToRead: reasons)
            print("New file added")
        }
        super.navigationController?.popViewController(animated: true)
        delegate?.updateView()
        
    }
    
    var bookController: BookController?
    var book: Book?
    var delegate: DetailViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        if var book = book {
            titleTextField.text = book.title
            reasonsTextView.text = book.reasonToRead
            self.title = book.title
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
