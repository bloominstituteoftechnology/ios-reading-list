//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dustin Koch on 1/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

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

    
    
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var bookTitle: UITextField!
    @IBOutlet weak var reasonToRead: UITextView!
    @IBAction func save(_ sender: UIBarButtonItem) {
        
    }
    
    
    
}
