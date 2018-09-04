//
//  DetailViewController.swift
//  Reading List
//
//  Created by Farhan on 9/4/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var TitleLabel: UITextField!
    
    @IBOutlet weak var reasonView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: Any) {
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
