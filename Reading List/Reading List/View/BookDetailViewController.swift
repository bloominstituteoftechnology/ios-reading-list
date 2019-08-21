//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Joshua Sharp on 8/20/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var reasonTextView: UITextView!
    
    var book: Book?{
        didSet{
            updateViews()
        }
    }
    var bc: BookController?
    
    func updateViews () {
        guard let book = book else { return }
        titleTextField.text = book.title
        reasonTextView.text = book.reasonToRead
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        guard let bc = bc,
                let title = titleTextField.text,
                let reason = reasonTextView.text,
                !title.isEmpty,
                !reason.isEmpty else {return}
        
        bc.create(titled: title, withReason: reason)
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? ReadingListTableViewController {
            vc.tableView.reloadData()
        }
        
    }


}
