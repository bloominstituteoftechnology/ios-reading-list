//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by admin on 7/23/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonForReadingTextView: UITextView!
    
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
    }
    
    var bookController: BookController?
    var book: Book?
    
    func updateViews() {
        guard let book = book else { return }
        
        bookTitleTextField.text = book.title
        reasonForReadingTextView.text = book.reasonToRead
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
