//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by LambdaSchoolVM_Catalina on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
// ib outlets
    
    @IBOutlet weak var bookTitleTxtField: UITextField!
    @IBOutlet weak var reasonsToReadTxtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  // ib actions
    @IBAction func saveBtnWasPressed(_ sender: Any) {
    }
    
}
