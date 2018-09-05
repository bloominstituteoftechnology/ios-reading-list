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
    
    var bookController: BookController?
    
    var book: Book?
    
    func updateViews(){
        guard let book = book else {return}
        
        title = book.title
        
        
        TitleLabel.text = book.title
        reasonView.text = book.reasonToRead

    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let title = TitleLabel.text, let reason = reasonView.text else {return}
    
    if let book = book {
        bookController?.updateTitleAndReason(for: book, title: title, reason: reason)
    } else {
       bookController?.createBook(title: title, reason: reason)
    }
        
    navigationController?.popViewController(animated: true)
        
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
