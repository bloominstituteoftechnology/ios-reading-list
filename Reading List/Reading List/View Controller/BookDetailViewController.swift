//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_22 on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func save(_ sender: Any) {
    }
    
    @IBOutlet weak var bookTitleLabel: UITextField!
    @IBOutlet weak var textView: UITextView!
}
