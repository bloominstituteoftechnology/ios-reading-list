//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by De MicheliStefano on 31.07.18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Methods
    @IBAction func save(_ sender: Any) {
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
}
