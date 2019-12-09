//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by LambdaSchoolVM_Catalina on 12/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    //outlets
    
    @IBOutlet weak var bookTitleLbl: UILabel!
    @IBOutlet weak var readUnreadBtn: UIButton!
    
    var book: Book? {
        didSet {
             updateViews()
        }
    }
    
    var delegate: BookTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //actions
    @IBAction func bookReadBtnActivated(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        bookTitleLbl.text = book.title
//        if readUnreadBtn.isSelected = UIImage(named: "checked") {
//        } else {
//            UIImage(named: "unchecked")
//        }
        if book.hasBeenRead {
            let image = UIImage(named: "checked")
            readUnreadBtn.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "unchecked")
            readUnreadBtn.setImage(image, for: .normal)
        }
    }

}
