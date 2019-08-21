//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var book: Book?
    var delegate: manageBookDelegate?
    
    func updateViews () {
        guard let book = book else { return }
        titleTextField.text = book.title
        reasonTextView.text = book.reasonToRead
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        if let book = book {
            guard let title = titleTextField.text,
                let reason = reasonTextView.text,
                !title.isEmpty,
                !reason.isEmpty else {return}
            delegate?.updateBook(book: book, title: title, reason: reason)
//            dismiss(animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        } else {
            guard let title = titleTextField.text,
                let reason = reasonTextView.text,
                !title.isEmpty,
                !reason.isEmpty else {return}
            delegate?.createBook(title: title, reason: reason)
            //bc.create(titled: title, withReason: reason)
            dismiss(animated: true, completion: nil)
        }
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ReadingListTableViewController {
            vc.tableView.reloadData()
        }
        
    }


}
