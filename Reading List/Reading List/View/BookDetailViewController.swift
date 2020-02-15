//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Claudia Contreras on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bookTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func saveTapped(_ sender: Any) {
    }
    
}
