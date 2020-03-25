//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Cameron Collins on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var TextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews()
    }
    
    //Variables
    var bookController: BookController?
    var book: Book?
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        guard let myBook = book else {
            if let myField = TextField.text, let myTextView = TextView.text
            {
                bookController?.createBook(hasBeenRead: false, title: myField, reasonToRead: myTextView)
            }
            
            return
        }
        
    }
    
    func updateViews() {
        guard let myBook = book else {
            return
        }
        
        TextField.text = myBook.title;
        TextView.text = myBook.reasonToRead
        title = myBook.title
    }
    
    
    
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
    */

}
