//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Rob Vance on 4/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
//Mark: IBOutlets
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    var bookController: BookController?
    var book: Book?
// Mark: IBActions
    @IBAction func saveTapped(_ sender: Any) {
        guard let title = bookTitleTextField.text,
            let reasonToRead = reasonTextView.text,
            !title.isEmpty, !reasonToRead.isEmpty else {return}
        
        if let book = book {
                  bookController?.update(book: book, with: title, and: reasonToRead)
              } else {
                  bookController?.createBook(title: title, reasonToRead: reasonToRead)
              }
              if let parent = navigationController?.viewControllers.first as? ReadingListTableViewController {
                  parent.tableView.reloadData()
              }
              navigationController? .popViewController(animated: true)
    }
    func updateViews() {
        guard let book = book else { return }
            title = book.title
            bookTitleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
    }
    
    


}
