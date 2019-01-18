//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Angel Buenrostro on 1/18/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let book = book else {
            guard let title = textField.text, let reason = textView.text  else { return }
            bookController?.Create(title: title, reason: reason)
            bookController?.saveToPersistentStore()
            navigationController?.popViewController(animated: true)
            return
        }
        guard let title = textField.text, let reason = textView.text  else { return }
        bookController?.updateTitleOrReason(for: book, newTitle: title , newReason: reason)
        bookController?.saveToPersistentStore()
        print(bookController!.books.count)
        navigationController?.popViewController(animated: true)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews(){
        guard let book = book else {
            navigationItem.title = "Add a new book"
            return }
        textField.text = book.title
        textView.text = book.reasonToRead
        navigationItem.title = book.title
    }

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        
//        switch segue.identifier{
//        case "addDetailSegue":
//            let detailVC = segue.destination as! BookDetailViewController
//            detailVC.bookController = bookController
//        case "cellDetailSegue":
//            let detailVC = segue.destination as! BookDetailViewController
//            let book = book
//            detailVC.bookController = bookController
//            detailVC.book = book
//        }
        
        
        // Pass the selected object to the new view controller.
        
        
        
    


}
