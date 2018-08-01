//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Carolyn Lea on 7/31/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell
{

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book?
    {
        didSet
        {
            updateViews()
        }
    }
    
    @IBAction func toggleCheckbox(_ sender: Any)
    {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    func updateViews()
    {
        guard let book = book else {return}
        bookTitleLabel.text = book.title
        
        guard let readButtonImage: UIImage = UIImage(named: "checked"),
            let unreadButtonImage: UIImage = UIImage(named: "unchecked") else {return}
        
        if book.hasBeenRead
        {
            checkBoxButton.imageView?.image = readButtonImage
        }
        else
        {
            checkBoxButton.imageView?.image = unreadButtonImage
        }
        
    }
    
}
