//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Drew Miller on 5/19/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    @IBOutlet weak var bookTitleOutlet: UITextField!
    @IBOutlet weak var bookReasonsOutlet: UITextView!

    @IBAction func saveBookAction(_ sender: Any) {
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
