//
//  ViewController.swift
//  Reading List
//
//  Created by Ian French on 4/26/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

   
    @IBOutlet weak var reasonTextView: UITextView!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    var bookController: BookController?
    var book: Book?
    
    
    
    @IBAction func savePressed(_ sender: Any) {
        
    
        guard let title = titleTextField.text,
            let reason = reasonTextView.text,
            !title.isEmpty, !reason.isEmpty else
            { return }
  
    
        if let book = book {
            bookController?.updateBook(for: book, with: title, and: reason)
              } else {
                  bookController?.createBook(title: title, reasonToRead: reason)
              }
              if let parent = navigationController?.viewControllers.first as? ReadingListTableViewController {
                  parent.tableView.reloadData()
              }
              navigationController? .popViewController(animated: true)
    }
    

    
    
    func updateViews() {
        guard let book = book else { return }
            title = book.title
            titleTextField.text = book.title
            reasonTextView.text = book.reasonToRead
    }
    


}
