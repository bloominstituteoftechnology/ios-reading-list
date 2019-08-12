//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Eoin Lavery on 11/08/2019.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //Outlets for cell UI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    //Variables to hold BookTableViewDelegate and Book objects
    var delegate: BookTableViewDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    //Updates cell views, called when cell is passed a value for book
    func updateViews() {
        
        //UIColor variables to hold colors for cell background colours
        let greenCellColor = UIColor(red: 0.749, green: 0.8784, blue: 0.102, alpha: 1.0)
        let redCellColor = UIColor(red: 1, green: 0.5686, blue: 0.5686, alpha: 1.0)
        
        //Checks for value of book and sets cell UI depending on properties of book
        guard let book = book else { return }
        titleLabel.text = book.title
        
        if book.hasBeenRead == true {
            guard let image = UIImage(named: "checked") else { return }
            hasBeenReadButton.setImage(image, for: .normal)
            self.backgroundColor = greenCellColor
        } else {
            guard let image = UIImage(named: "unchecked") else { return }
            hasBeenReadButton.setImage(image, for: .normal)
            self.backgroundColor = redCellColor
        }
    }
    
    //Call delegate function in ReadingListTableViewController when hasBeenReadButton is tapped
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
}
