//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Hector Steven on 4/30/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
    }
	
	@IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
		print("save")
	
	}
	
	func setupviews(){
		guard let book = book else { return }
		bookTitleTextField.text = book.title
		reasonToReadTextView.text = book.reasonToRead
		
	}
	
	@IBOutlet var bookTitleTextField: UITextField!
	@IBOutlet var reasonToReadTextView: UITextView!
	var book: Book?
}
