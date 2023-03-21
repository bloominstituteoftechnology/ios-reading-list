//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Harm on 3/21/23.
//  Copyright © 2023 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
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
