//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Jordan Davis on 5/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    
 
    
    
    //MARK: -Properties
    
    @IBOutlet var bookTitleTextField: UITextField!
    
    @IBOutlet var reasonTextView: UITextView!
    
}
