//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by user162867 on 12/17/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var book: Book?
    weak var delegate: BookTableViewCellDelegate?

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate.toggleHasBeenRead(for cell: ...)
    }
    
    func updateViews() {
        title.text = book?.title
        if let image = UIImage(named: "checked") {
            button.setImage(image, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
