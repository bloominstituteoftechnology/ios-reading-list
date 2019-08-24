//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Joseph Rogers on 8/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailTextField: UITextField!
    
    var bookController: BookController?
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    
    func updateViews() {
        
    }
    
    @IBAction func saveTapped(_ sender: Any) {
      
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
