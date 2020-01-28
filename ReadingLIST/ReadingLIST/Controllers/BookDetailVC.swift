//
//  BookDetailVC.swift
//  ReadingLIST
//
//  Created by Nick Nguyen on 1/28/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit

class BookDetailVC: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
       
    }
    

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
    }
    
}
