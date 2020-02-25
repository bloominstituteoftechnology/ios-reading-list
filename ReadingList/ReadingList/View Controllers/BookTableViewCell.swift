//
//  ReadingListTableViewCell.swift
//  ReadingList
//
//  Created by Lambda_School_Loaner_259 on 2/25/20.
//  Copyright © 2020 DeVitoC. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hasBeenReadButton: UIButton!
    
    
    // MARK: - IBActions
    @IBAction func hasBeenReadButtonTapped(_ sender: Any) {
    }
    
    // MARK: - Properties
    var book: Book?
    let checkedImage = UIImage(named: "checked")!
    let uncheckedImage = UIImage(named: "unchecked")!
    
    func updateViews() {
        guard let book = book else { return }
        titleLabel.text = book.title
        
    }

}
