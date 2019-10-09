//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Lambda_School_Loaner_201 on 10/6/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    var bookController: BookController?
    var book: Book?
    
    func updateView() {
        
    }
    
    @IBOutlet weak var bookTextField: UITextField!
    @IBOutlet weak var bookTextView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        guard book != nil else {
            let title = bookTextField.text ?? ""
            let reason = bookTextView.text ?? ""
            
            bookController?.createNewBook(title: title, reasonToRead: reason)
            navigationController?.popViewController(animated: true)
            updateView()
            return
            
           
        }
    
        let title = bookTextField.text
        let reason = bookTextView.text
        
        bookController?.updatehasBeenRead(for: book!)
        navigationController?.popViewController(animated: true)
        
        updateView()
    }
    
    
}
