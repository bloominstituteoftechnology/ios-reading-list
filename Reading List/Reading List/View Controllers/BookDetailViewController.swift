//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by John Holowesko on 12/8/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var bookTitleTextField: UITextField!
    @IBOutlet var bookReasonToReadTextField: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - IBActions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    

}
