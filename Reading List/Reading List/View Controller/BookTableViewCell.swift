//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Ilgar Ilyasov on 9/11/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    var book: Book? {
        didSet { updateViews() }
    }
    
    weak var cellDelegate: BookTableViewCellDelegate?
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        cellDelegate?.toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        guard let title = book?.title,
              let status = book?.hasBeenRead,
              let checkImage = UIImage(named: "checked"),
              let uncheckedImage = UIImage(named: "unchecked") else { return }
        
        bookTitleLabel.text = title
        
        if status == true {
            checkButtonOutlet.setImage(checkImage, for: .normal)
        } else {
            checkButtonOutlet.setImage(uncheckedImage, for: .normal)
        }
    }
}
